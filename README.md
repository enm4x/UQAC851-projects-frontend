# UQAC851 Software Engineering Projects Frontend

Course : UQAC851 - Software Engineering

Projetc : PrixBanque | A software engineering classes projects  

Framework : Flutter 

- version : Flutter 2.0.4

Status : [![UQAC851 - frontend](https://github.com/maxdvlg/UQAC851-Projects-Frontend/actions/workflows/dart.yml/badge.svg)](https://github.com/maxdvlg/UQAC851-Projects-Frontend/actions/workflows/dart.yml)

# :heavy_exclamation_mark: Related projects : 

- :bank: PrixBanque_backend : [https://github.com/ethicnology/uqac-851-software-engineering-api](https://github.com/ethicnology/uqac-851-software-engineering-api)

# :construction_worker: How to install this project

## Local/Native installation 

### Install dependencies

- [Flutter & Dart](https://flutter.dev/docs/get-started/install)
- [Android studio](https://developer.android.com/studio)

### Clone the project 

``` 
git clone git@github.com:maxdvlg/UQAC851-projects-frontend.git 
```

### Add a .env file

You must create a .env file containing the local variable that will allow the project to be built with the correct sources

```
# Create a .env file a the root of the project
touch app/.env

# Define the variable URL_PROD
# URL_PROD=myapiadress.com:port in the .env file
echo URL_PROD=myapiadress.com:port >> app/.env
```

# Testing

- pre-requisites: you must finish the task [How to install this project]


### Execute all tests available

```
# Change directory to the root folder
cd .../app

# Perform global test
$ flutter test

```
### Execute a specific test

```
# Change directory to the root folder
cd .../app

# Perform specific test
flutter test test/myspecificfunctions_test.dart

```
