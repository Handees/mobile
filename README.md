# Handees Mobile App

## Design Pattern

This project uses the MVVM pattern.

## Project Structure

Under lib/apps, you have 2 apps, one for the customer and the other for the artisan.

Each app should have features and services folder under it.
This rule is not set in stone as data that is specific to either app can be stored under that app's folder.

### Features

For each feature, you would have two folders

- 'ui': This is where all user interface files are to be placed. It should be split into screens and widgets if need be.
- 'providers': This folder contains the viewmodels based on the mvvm pattern but for convenience, they are being called providers here.
  
### Services

These are the services belonging to only that app and they are mostly singleton classes. There are services under 'lib/shared' and those services belong to both apps.

### Data

This folder is where the models of the data being passed around are stored. It is also home to the repositories of the providers. These repositories basically fetch data either locally or from endpoints and pass it to the Providers.

## Naming Convention

All files should be named based on their type to allow for easier searching e.g

- Home Screen - 'home.screen.dart'
- Chat Provider - 'chat.provider.dart'

## State Management

The state management library being used is Riverpod. To understand how this project utilizes it, go through this [article](https://blog.logrocket.com/statenotifier-improving-state-change-notifiers-flutter/)
