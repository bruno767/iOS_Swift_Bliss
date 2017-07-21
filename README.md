# QuestionList Swift 3.1

## Version

1.2

## Build and Runtime Requirements
+ Xcode 8.0 or later
+ iOS 9.0 or later

## Configuring the Project

Configuring the Xcode project requires a few steps in Xcode to get up and running. 

1) clone this project.
- git clone https://github.com/bruno767/iOS_Swift_Bliss.git

2) Open the finder and execute QuestionList.xcworkspace.

3) Run the project.

## About QuestionList

This is a project where the main feature in fetch data from an API (RESTful) and feed an UITableView, this app also allow the user filtrate and share the content, when the user click on the cell a detail screen is shown and it can vote on one of the itens and also share that item. 
I made a singleton Timer to run during the project and detect if the internet connect is valid, if it lost a connection a custom alert view is presented and dismissed if the internet connection turn on again. 

## Written in:

This project is written in Swift 3.1. 

## Application Architecture

For this project I used MVVM for the core of the application and for the peripheral content screen i used MVC just to be simple.

### Shared Code

I used a shared code from https://stackoverflow.com/a/39782859 to make a Reachability class and know if the internet connection in valid and https://stackoverflow.com/a/42339345 to make a singleton Timer and run during the running app. 

Thanks guys.

#### Extensions 

I created a file ViewControllerExtensions to put some functions that I am using more than one viewController. 

#### Contact

Feel free to contact if you want to share knowledge

Copyright (C) Bruno Alves. 
