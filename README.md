[![UQAC851 - frontend](https://github.com/maxdvlg/UQAC851-Projects-Frontend/actions/workflows/dart.yml/badge.svg)](https://github.com/maxdvlg/UQAC851-Projects-Frontend/actions/workflows/dart.yml)

# UQAC851 Software Engineering Projects Frontend
Course : UQAC851 - Software Engineering

Project : PrixBanque | A software engineering classes projects  

Framework : Flutter 
- version :  2.0.4



# :heavy_exclamation_mark: Related projects : 

- :bank: [**back-end** : prix-banque-api ](https://github.com/ethicnology/uqac-851-software-engineering-api)

# :construction_worker: How to install this project

## Installation

### Prerequisites
- [Flutter & Dart](https://flutter.dev/docs/get-started/install) is enough if you just want to build web version for testing purposes
- [Android studio](https://developer.android.com/studio) is needed for development and if you want to build Android & IOS applications

### Clone the project 
``` 
git clone git@github.com:maxdvlg/UQAC851-projects-frontend.git 
cd UQAC851-projects-frontend
```

### Configuration
Rename **.env.example** to .env in **./app/** folder :
```sh
mv app/.env.example app/.env
```

Specify the API URL docker network or VPS :
```ini
URL_PROD=dissidence.dev:9999 # if docker use 172.x.x.x:1984
```

# :rocket: Usage
```sh
flutter doctor # verify your installation
```

Build web version
```sh
flutter run -d chrome
```

# Testing
- pre-requisites: you must finish the task [How to install this project]

### Execute all tests
Change directory to the **app** folder
```sh
cd app
```
Perform global test
```sh
flutter test  
```
### Execute specific test
To execute specific test you can execute 
```sh
flutter test test/myspecificfunctions_test.dart
```
