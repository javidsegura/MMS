from django.shortcuts import render
from django.http import JsonResponse
from django.db import connection

def full_text_search(request):
    query = request.GET.get('query', '')  # Retrieve the search term from the request
    if not query:
        return JsonResponse({'error': 'No query provided'}, status=400)
    
    # Perform a full-text search
    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT id, name, description, price, currency, available
            FROM menus_menuitem
            WHERE MATCH(name, description) AGAINST (%s IN NATURAL LANGUAGE MODE)
            """,
            [query]
        )
        results = cursor.fetchall()

    # Format results into JSON response
    formatted_results = [
        {
            'id': row[0],
            'name': row[1],
            'description': row[2],
            'price': row[3],
            'currency': row[4],
            'available': row[5]
        }
        for row in results
    ]

    return JsonResponse(formatted_results, safe=False)
