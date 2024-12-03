"""
This module defines middleware for logging HTTP requests and responses in a Django application.
It logs key details such as request headers, parameters, body, and response details, including
status code, headers, and execution time.

Dependencies:
    - logging
    - json
    - time
    - django.conf.settings
"""

import logging
import json
import time
from django.conf import settings

logger = logging.getLogger('app')


class LoggingMiddleware:
    """
    Middleware for logging HTTP requests and responses in the application.

    Attributes:
        get_response (callable): The next middleware or view in the Django request/response cycle.
    """

    def __init__(self, get_response):
        """
        Initializes the middleware with the get_response function.

        Args:
            get_response (callable): The next middleware or view in the request/response cycle.
        """
        self.get_response = get_response

    def __call__(self, request):
        """
        Handles the request and response logging.

        Args:
            request (HttpRequest): The incoming HTTP request.

        Returns:
            HttpResponse: The outgoing HTTP response after processing the request.
        """
        # Start timing the request
        start_time = time.time()

        # Log request details
        self.log_request(request)

        # Get response
        response = self.get_response(request)

        # Calculate request duration
        duration = time.time() - start_time

        # Log response details
        self.log_response(response, duration)

        return response

    def log_request(self, request):
        """
        Logs details about the incoming HTTP request.

        Args:
            request (HttpRequest): The HTTP request to log.

        Captures:
            - Request method (GET, POST, etc.)
            - Path
            - User (authenticated user or anonymous)
            - GET and POST parameters
            - Request body (if not binary)
            - Headers
        """
        body = None
        if request.body:
            try:
                body = json.loads(request.body)
            except (json.JSONDecodeError, UnicodeDecodeError):
                # If it's binary data, just note that instead of trying to decode it
                body = '<binary data>'

        log_data = {
            'type': 'request',
            'method': request.method,
            'path': request.path,
            'user': str(request.user),
            'GET_params': dict(request.GET),
            # Only include POST params if they're not multipart form data (files)
            'POST_params': dict(request.POST) if not request.content_type.startswith('multipart/form-data') else '<file upload>',
            'body': body,
            'headers': dict(request.headers),
        }

        logger.info(f"Request: {json.dumps(log_data, indent=2)}")

    def log_response(self, response, duration):
        """
        Logs details about the outgoing HTTP response.

        Args:
            response (HttpResponse): The HTTP response to log.
            duration (float): The time taken to process the request, in seconds.

        Captures:
            - Response status code
            - Response content (if not binary)
            - Headers
            - Duration of the request
        """
        content = None
        if hasattr(response, 'content'):
            if response.get('Content-Type', '').startswith(('image/', 'application/', 'multipart/form-data')):
                content = '<binary data>'
            else:
                try:
                    content = json.loads(response.content)
                except (json.JSONDecodeError, UnicodeDecodeError):
                    content = '<undecodable content>'

        log_data = {
            'type': 'response',
            'status_code': response.status_code,
            'content': content,
            'duration': f"{duration:.2f}s",
            'headers': dict(response.headers),
        }

        logger.info(f"Response: {json.dumps(log_data, indent=2)}")
