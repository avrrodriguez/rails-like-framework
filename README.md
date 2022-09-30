# Rails-like Framework

A clone of the Ruby on Rails framework using a blog application as an example.

## Description

Using this framework one is able to add a controller with specific names, models for a database in which to store information, and a html or some other file to render whatever the user wants to render. The framework already has the connection between the controller, views, and models. The way the controller establishes that connection is also dynamic, the user can give the controller whatever name it wants followed by "-controller" and the framework will be able to connect that to its appropriate model and views. 

- This framework uses Ruby Programming Language. 
- Rack is used to create the connection between the front-end and back-end. 
- It has html.erb functionality for writing ruby code inside html. 
- The database is sqlite3. 
- Some Regex is used as well for formatting the front end requests.
