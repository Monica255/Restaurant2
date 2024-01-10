

# iOS App 2nd Submission

This repository showcases the implementation of an iOS app that fulfills the specified criteria for the submission. The app adheres to the following key requirements:

## Continuous Integration

Continuous Integration (CI) is implemented using [Codemagic](https://codemagic.io/). The CI process ensures successful debugging and provides a seamless development workflow. The Codemagic CI pipeline reflects the latest successful build status.

[![Codemagic build status](https://api.codemagic.io/apps/659e24ede4e8f9de9d286808/ios-project-debug/status_badge.svg)](https://codemagic.io/apps/659e24ede4e8f9de9d286808/ios-project-debug/latest_build)

## Modularization

The app incorporates modularization using Swift Package Manager (SPM) and adheres to a modular architecture. Each app feature is encapsulated into a separate module framework, promoting code organization and maintainability.

### Modules

1. [**Core Module**](https://github.com/Monica255/Restaurant2/tree/main/Modules/Core): Contains Core Data implementations.
2. [**Home Module**](https://github.com/Monica255/Restaurant2/tree/main/Modules/Home): Displays a list of restaurants.
3. [**Detail Module**](https://github.com/Monica255/Restaurant2/tree/main/Modules/Detail): Displays details of a restaurant.
4. [**Favorite Module**](https://github.com/Monica255/Restaurant2/tree/main/Modules/Favorite): Manages favorited restaurants.

## Clean Architecture

The app follows Clean Architecture principles to ensure a clear and maintainable code structure. This architecture separates concerns and promotes testability.

## Dependency Injection

Dependency Injection is implemented throughout the app, facilitating loose coupling and making components easily replaceable.

## Reactive Programming

Reactive Programming is utilized using RxSwift to enhance the app's responsiveness and maintainability. The use of reactive patterns ensures a reactive and scalable architecture.

## Wireframe Design

The following design have been incorporated into the app:

- [Link to lo-fi/mockup/wireframe changes](<link to design changes>)

