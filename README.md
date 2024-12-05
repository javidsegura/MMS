# Description

Menu management system for restaurant. ETL pipeline. Django in the backend, RDS and S3 used in the cloud infrastructure.

# Dependencies

- Python 3.11
- Django 4.2.10
- MySQL 8.0
- OpenAI API
- Please read other/documentation for more information on environment variables and other dependencies

# Repository structure
```
├── README.md                         # Contains the project overview, installation instructions, usage, and any other essential information.
├── others                             # A directory that holds additional resources and examples.
│   ├── demoVid                        # Contains video demonstration files.
│   │   └── demo.mov                   # A demo video file showcasing the project or application in action.
│   ├── documentation                  # Holds documentation files for the project.
│   │   └── documentTree.txt           # A file that outlines the structure or content of the documentation.
│   └── menuExamples                   # Holds examples related to restaurant menus.
│       ├── html                       # Contains HTML files related to the project.
│       │   └── myMenu.html            # A sample HTML menu.
│       ├── images                     # Holds images used in the project.
│       │   ├── PDF-Menus-For-Restaurants (1).png # Image of a PDF menu example.
│       │   ├── buffalo_bill.jpg       # Image of a menu or restaurant.
│       │   ├── defaultRestaurant.png  # Default restaurant image for menus.
│       │   ├── fiveguys.png          # Image for Five Guys restaurant.
│       │   └── gordoRamsayPF.png      # Image for Gordo Ramsay restaurant.
│       └── pdfs                        # Contains PDF menu files.
│           ├── nobu.pdf              # PDF of Nobu restaurant menu.
│           ├── nusr_et.pdf           # PDF of Nusr-Et restaurant menu.
│           └── sample_menu.pdf       # A sample menu in PDF format.
├── requirements.txt                  # Lists the Python dependencies for the project.
└── src                                # Source code for the application.
    ├── API                            # Contains files related to API integration.
    │   └── APIs.py                    # Python file with API definitions or client-side logic.
    ├── database                       # Contains database-related files.
    │   ├── dataManipulation.sql       # SQL file for manipulating database data.
    │   ├── datePermissions.sql        # SQL for handling permissions based on dates.
    │   ├── events.sql                 # SQL for managing events data.
    │   ├── fullTextsearch.sql         # SQL for enabling full-text search in the database.
    │   ├── materializedViews.sql      # SQL for creating materialized views in the database.
    │   ├── mms_snapshot.sql           # SQL for taking database snapshots.
    │   ├── schemaNotes.md             # Documentation or notes on the database schema.
    │   └── triggers.sql               # SQL for setting up database triggers.
    ├── django_project                 # Contains the Django project files and configuration.
    │   ├── django_project             # Main Django application directory.
    │   │   ├── __init__.py            # Indicates that the directory is a Python package.
    │   │   ├── asgi.py                # ASGI configuration for the Django app (for asynchronous support).
    │   │   ├── settings.py            # Django settings file, where configurations for the app are defined.
    │   │   ├── urls.py                # URL routing for the Django app.
    │   │   └── wsgi.py                # WSGI configuration for deploying the app with WSGI-compatible servers.
    │   ├── logs                        # Contains log files for the Django application.
    │   │   └── django_javierdominguezsegura.log # Log file for tracking Django app's events and errors.
    │   ├── manage.py                  # The main command-line utility for managing Django projects (e.g., starting the server).
    │   ├── menus                       # Contains code related to menus within the project.
    │   │   ├── __init__.py             # Indicates that the menus directory is a Python package.
    │   │   ├── admin.py               # Configuration for Django admin interface related to menus.
    │   │   ├── apps.py                # App configuration for Django menus app.
    │   │   ├── migrations             # Contains migration files for changes to the database schema related to menus.
    │   │   ├── models.py              # Django models that define the data structure for the menus.
    │   │   ├── serializers.py         # Serializers for transforming Django model instances into JSON or other formats.
    │   │   ├── tests.py               # Tests for the menu-related functionality.
    │   │   ├── urls.py                # URL routing for menu-related views.
    │   │   └── views.py               # Views for handling the business logic and rendering of menus.
    │   ├── scripts                     # Contains bash scripts for server management and user creation.
    │   │   ├── createuser.bash        # Bash script for creating a user.
    │   │   ├── startServer.bash       # Bash script for starting the server.
    │   │   └── update.bash            # Bash script for updating the server.
    │   └── utils                       # Contains utility files for the project.
    │       └── logging_middleware.py   # Middleware for logging requests and responses in Django.
    └── notes.txt                       # A text file for taking project-related notes or additional information.
```

# Contributions
Please, create your own branch and send a pull request. Make sure you have installed all the dependecies in the requirements.txt file.

1. Make sure u understand the main parts of the codebase. Have installed all the dependencies
2. Create a file named .env withing the outermost django_project folder 
3. Populate the .env file with the following keys:
      - DB_HOST="localhost"
      - DB_PASSWORD="yourpassword"
      - DB_USER="root"
      - DB_NAME="database_name"
      - DB_PORT="3306"
      - OPENAI_API_KEY="your_openai_api_key"
4. Create a superuser using the createuser.bash script
5. Run the migrate.bash script to update the database
7. Go to http://127.0.0.1:8000/admin/ to access the admin interface

