import base64
import os
from openai import OpenAI
import json
from menus.models import AuditLog, Menu
from PyPDF2 import PdfReader


def ai_call(menu: Menu, extension: str) -> tuple[dict, AuditLog]:
    """ Send the menu file to OpenAI to process 
    
    Note: extension is the file extension of the menu file (e.g: .png, .html, .pdf)
    """
    print(f"AI call for uploaded file. Extension: {extension}")
    
    menu_file = menu.menu_file
    ai_call_log = AuditLog.objects.create(
        phase="Extraction",
        status="Processing"
    )
    try:
        if extension not in ["png", "html", "pdf", "jpg", "jpeg"]:
            raise ValueError(f"Unsupported file extension: {extension}")
        
        # OpenAI API call
        client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

        messages = [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": """Please analyze this menu image and return a JSON with the following structure. Dont add any comments or explanations. If the content is not a menu, return an empty JSON:
                            {
                                "menu_sections": [
                                    {
                                        "name": "section name",
                                        "items": [
                                            {
                                                "name": "item name",
                                                "description": "item description",
                                                "price": float,
                                                "currency": string,
                                                "available": boolean,
                                                "dietary_restrictions": dietary_restrictions = [
                                                                                        "Vegetarian",
                                                                                        "Vegan",
                                                                                        "Gluten-Free",
                                                                                        "Dairy-Free",
                                                                                        "Nut-Free",
                                                                                        "Halal",
                                                                                        "Kosher",
                                                                                        "Pescatarian",
                                                                                        "Low-Carb",
                                                                                        "Low-Sodium",
                                                                                        "Soy-Free",
                                                                                        "Egg-Free",
                                                                                        "Shellfish-Free",
                                                                                        "Sugar-Free",
                                                                                        "Peanut-Free",
                                                                                        "Paleo",
                                                                                        "Keto",
                                                                                        "Whole30",
                                                                                        "FODMAP-Friendly",
                                                                                        "No Pork",
                                                                                        "Organic-Only"
                                                                                    ]
                                            }
                                        ]
                                    }
                                ]
                                "restaurant_info":{
                                    "restaurant_name": "restaurant name", #may be extracted from the webiste url
                                    "address": "restaurant address",
                                    "phone": "restaurant phone",
                                    "website": "restaurant website"
                                    "email": "restaurant email"
                                    "country": "restaurant country",
                                    "city": "restaurant city",
                                    "state": "restaurant state",
                                    "zip": "restaurant zip" # -1 if not available
                                    "street": "restaurant street"
                                }
                            }"""
                        }
                    ]
                }
            ]
        
        # Adjusting based on the file extension
        if extension in ["png", "jpg", "jpeg"]:
            base64_file = base64.b64encode(menu_file.file.read()).decode('utf-8')

            type = "jpeg" if extension in ["jpg", "jpeg"] else extension

            messages[0]["content"].append({
                "type": "image_url",
                "image_url": {
                    "url": f"data:image/{type};base64,{base64_file}"
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
            model="gpt-4o",
            messages=messages
        )
        # Handling the case where the content is not a menu
        if response.choices[0].message.content == "{}":
            ai_call_log.status = "Failed"
            ai_call_log.other = "No menu found in the image"
            ai_call_log.save()
            menu.delete() # Dont store the menu if it is not a menu
            return None, ai_call_log

        # Extracting the JSON from the markdown
        content = response.choices[0].message.content.replace('```json', '').replace('```', '').strip()
        print(f"Raw content from OpenAI: {content}")  
    
        try:
            # Remove markdown from JSON
            json_str = content[content.find('{'):content.rfind('}')+1]
            print(f"Extracted JSON string: {json_str}")  
            
            # Parse JSON in string to actual JSON
            try:
                json_response = json.loads(json_str)
            except json.JSONDecodeError as json_err:
                print(f"JSON parsing error at position {json_err.pos}: {json_err.msg}")
                print(f"Problematic portion: {json_str[max(0, json_err.pos-50):min(len(json_str), json_err.pos+50)]}")
                raise
                
            print(f"Successfully parsed JSON: {json_response}")
            ai_call_log.status = "Success"
            return json_response, ai_call_log
        
        except Exception as e:
            print(f"Error processing OpenAI response: {str(e)}")
            ai_call_log.status = "Failed"
            ai_call_log.other = f"Error processing response: {str(e)}\nRaw content: {content[:500]}..."  # Store first 500 chars of content
            ai_call_log.save()
            return None, ai_call_log
    
    except Exception as e:
        print(f"Error in ai_call: {str(e)}")
        try:
            ai_call_log.status = "Failed"
            ai_call_log.other = str(e)
            return None, ai_call_log
        except:
            pass
