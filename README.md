# Rails-like Framework

An MVC framework inspired by Ruby on Rails using a blog application as an example.

## Description

Using this framework one is able to add a controller with specific names, models for a database in which to store information, and a html or some other file to render whatever the user wants to render. The framework already has the connection between the controller, views, and models. 

- This framework uses Ruby Programming Language. 
- Rack is used to create the connection between the front-end and back-end. 
- It has html.erb functionality for writing ruby code inside html. 
- The database is sqlite3. 
- Some Regex is used as well for formatting the front end requests.

## How to use

### Start application
- To start application, run "rackup" in the terminal

### To add table to database
- Either create a migration file in the migrations folder
	- done in the migration format, number of latest migration file number plus one for next number followed by _create_table, inside the file should have the same format as previous files.
	- another way, inside the seed file, create new Functions instance and then use the create_table function to create a new table, with the format newtable.create_table(table_name, *options). Options is optional, there you would include the column names and data types as a single string.
```
		new_table = Function.new
		new_table.create_table(table_name, "id integer, title string, comments text")
```

### Creating models
- Add file(s) in the models folder, file name should be singular form of table in database with the same name, inside should be a class with the same name as the folder.
```
# post.rb
class Post < Sequel::Model(DB)
  insert code here
end
```


### Creating controllers
- Add file(s) in controller folder, file should be named the same as the table(plural and lowercare) followed by _controller.rb. Inside the file should be a class with the name capitalized and the same as folder name but without the _, Example, class PostsController inside file posts_controller.


### Adding routes
- The routes are already connected to the controller, there is no need to write any extra code other than to enter the http verb, action, and controller.
- Inside the routes.yml is where routes are inputted, with the following format:
```
	 "path":
		-
		   "http-verb": "controller#action"
```

### Creating Views
- The user needs to create a folder with the name of the table it is connected to (in plural) and within that folder place the appropriate views files.


### Additional functionalities
- The framework is capable of supporting crud applications.
- Within the seed file, the user is capable of joining multiple tables, destroying tables, adding columns to tables, deleting columns from tables through the Functions class of required db_functions file.
```
table = Function.new
table.name = "table_name"

# drop table
table.drop

# join tables
table.join(table1, table1_column, table2, table2_matching_column)

# get table schema
table.schema

# add column
table.add_column(column_name, data_type, *options) # options are constraints like primary key

# delete_column
table.drop_column(column_name)
```
- The schemas of all tables in the database can be found in schema file.
