import base64
import os
from openai import OpenAI
import json
from menus.models import AuditLog, Menu
from PyPDF2 import PdfReader

# TO DO: get a dict with all the info. Then write it to the db

def ai_call(menu, extension):
    """ Send the menu file to OpenAI to process 
    
    Note: extension is the file extension of the menu file (e.g: .png, .html, .pdf)
    """
    print(f"AI call for uploaded file. Extension: {extension}")
    menu_file = menu.menu_file
    ai_call_log = AuditLog.objects.create(
        phase="Extraction",
        status="Started"
    )
    try:
        # OpenAI API call
        client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

        messages = [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": """Please analyze this menu image and return a JSON with the following structure:
                            {
                                "menu_sections": [
                                    {
                                        "name": "section name",
                                        "items": [
                                            {
                                                "name": "item name",
                                                "description": "item description",
                                                "price": float,
                                                "dietary_restrictions": ["restriction1", "restriction2"]
                                            }
                                        ]
                                    }
                                ]
                                "restaurant_info":{
                                    "resturant_name": "restaurant name", #may be extracted from the webiste url
                                    "address": "restaurant address",
                                    "phone": "restaurant phone",
                                    "website": "restaurant website"
                                }
                            }"""
                        }
                    ]
                }
            ]
        
        if extension == "png":
            # Read image file directly from the InMemoryUploadedFile
            base64_file = base64.b64encode(menu_file.file.read()).decode('utf-8')
            # Reset file pointer for future reads
            menu_file.file.seek(0)

            messages[0]["content"].append({
                "type": "image_url",
                "image_url": {
                    "url": f"data:image/png;base64,{base64_file}"
                }
            })
        elif extension == "html":
            # Decode the content as UTF-8
            messages[0]["content"].append({
                "type": "text",
                "text": menu_file.file.read().decode('utf-8')
            })
        elif extension == "pdf":
            reader = PdfReader(menu_file.file)
            pdf_text = "\n".join(page.extract_text() for page in reader.pages)
            messages[0]["content"].append({
                "type": "text",
                "text": f"Here is the text extracted from the menu: {pdf_text}"
            })
                
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages
        )

        content = response.choices[0].message.content.replace('```json', '').replace('```', '').strip()

        print(f"Raw content from OpenAI: {content}")  # Add this debug line
    
        try:
            # Extract just the JSON part
            json_str = content[content.find('{'):content.rfind('}')+1]
            print(f"Extracted JSON string: {json_str}")  # Add this debug line
            
            # Try to parse with more lenient error handling
            try:
                json_response = json.loads(json_str)
            except json.JSONDecodeError as json_err:
                print(f"JSON parsing error at position {json_err.pos}: {json_err.msg}")
                print(f"Problematic portion: {json_str[max(0, json_err.pos-50):min(len(json_str), json_err.pos+50)]}")
                raise
                
            print(f"Successfully parsed JSON: {json_response}")
            
            ai_call_log.status = "Finished Successfully"
            return json_response, ai_call_log
        
        except Exception as e:
            print(f"Error processing OpenAI response: {str(e)}")
            ai_call_log.status = "Failed"
            ai_call_log.other = f"Error processing response: {str(e)}\nRaw content: {content[:500]}..."  # Store first 500 chars of content
            ai_call_log.save()
            raise
    
    except Exception as e:
        print(f"Error in ai_call: {str(e)}")
        ai_call_log.status = "Failed"
        ai_call_log.other = str(e)
        ai_call_log.save()
        raise e
