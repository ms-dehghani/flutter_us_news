# Us News

This is a simple News application that shows recent news to you. It is built using Flutter.
For fetch data from internet we used https://newsapi.org you can register and use it as free.
Also we cached all received data into local database to perform showing news when user is offline.

## Technologies

We are using the following technologies:

- Flutter & Dart
- Clean Architecture principles
- Modular structure
- Dependency Injection
- Unit test

## Architecture

The app is built using the Clean Architecture principles. The app is divided into 3 modules:
* `app` - The main module that contains the UI and the DI setup.
* `data` - The module that contains the data layer. It includes the repository and the data sources.
* `domain` - The module that contains the business logic. It includes the use cases and the data models.

Every module is independent and can be tested separately. also they work together to achieve the final result.
this architecture makes the app more maintainable and testable and also makes it easier to add new features.
each layer uses its own models and mappers to make the app more flexible and easy to maintain.
this is schema of the architecture:

![Alt text](./resource/architecture.png?raw=true "Architecture")

## UI
The UI is divided into 2 screens:
* `News List Screen` - The main screen that contains the list of last news sorted by published date and also arranged by news source.
* `News Detail Screen` - The screen that contains the details of a news.

![Alt text](./resource/main_screen.png?raw=true "News List Screen")
![Alt text](./resource/detail_screen.png?raw=true "News Detail Screen")


## Testing
The app contains unit tests and UI tests.
* `app` - Contains the UI tests.
* `data` - Contains the unit tests.
* `domain` - Contains the unit tests for the use cases.

Fork and enjoy! 🚀