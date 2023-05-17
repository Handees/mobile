# Handees Mobile App

## Design Pattern

This project uses the MVVM pattern.

## Project Structure

Under lib/apps, you have 2 apps, one for the customer and the other for the artisan.

Each app has a number of folders under it that can be seen as features

For each feature, you would have two folders

- 'ui': This is where all user interface files are to be placed. It should be split into screens and widgets if need be.
- 'providers': This folder contains the viewmodels based on the mvvm pattern but for convenience, they are being called providers here.

## Naming Convention

All files should be named based on their type to allow for easier searching e.g

- Home Screen - 'home.screen.dart'
- Chat Provider - 'chat.provider.dart'

## State Management

The state management library being used is Riverpod. To understand how this project utilizes it, go through this [article](https://blog.logrocket.com/statenotifier-improving-state-change-notifiers-flutter/)
