require "sequel"

class Functions
  def name(table_name)
    @table_name = table_name
  end

  def create_table(table_name, *options)
    db_new_table = "CREATE TABLE #{table_name} (#{options[0]})"
    puts db_new_table
    DB.run "#{db_new_table}"

    puts "#{table_name} table created"
    puts
    puts "Adding to schemas"

    @table_name = table_name
    to_schemas
  end

  def drop
    DB.drop_table @table_name.to_sym

    file_lines = ""
    f = File.open("/Users/abrahamrodriguez/Desktop/Actualize/framework/blog/app/db/schemas.rb", "r+")
    table_present = false
    line_number = 1
    f.each do |line|
      if line.include?(":#{@table_name}")
        table_present = true
      end
      if table_present
        if line == "\n"
          table_present = false
        end
        line_number += 1
      end
      file_lines += line unless table_present
    end
    f.close

    p file_lines

    File.open("/Users/abrahamrodriguez/Desktop/Actualize/framework/blog/app/db/schemas.rb", "w") do |file|
      file.puts file_lines
    end
  end

  def join(table1, table1_column, table2, table2_matching_column)
    db_join_tables = "SELECT * FROM #{table1} INNER JOIN #{table2} ON #{table1_column}=#{table2_matching_column}"
  end

  def schema
    DB.schema(@table_name.to_sym)
  end

  def to_schemas
    puts "writing to schemas file"

    f = File.open("/Users/abrahamrodriguez/Desktop/Actualize/framework/blog/app/db/schemas.rb", "a")
    table_data = schema
    f.write("\n")
    f.write("table name", " :#{@table_name}", "\n")
    table_data.each do |item|
      f.write(item[0], " ", item[1][:db_type], "\n")
    end

    f.close
  end

  def add_column(col_name, data_type, *options)
    new_column = "ALTER TABLE #{@table_name} ADD #{col_name} #{data_type} #{options}"
    DB.run "#{new_column}"
    to_schemas
  end

  def drop_column(col_name)
    drop_column = "ALTER TABLE #{@table_name} DROP #{col_name}"
    DB.run "#{drop_column}"
    to_schemas
  end

  def insert_row(columns = "", options)
    puts "inserting row into table"
    instance = "INSERT INTO #{@table_name} 
    #{columns}
    VALUES (#{options[0].to_i}, '#{options[1]}', '#{options[2]}', #{options[3].to_i});"
    puts instance
    DB.run "#{instance}"
  end

  def select_query(column = "*", options = {})
    puts "selecting query"
    select_string = "SELECT #{column} FROM #{@table_name}"
    if options[:where]
      select_string += "WHERE #{options[:where]}"
    end
    if options[:group_by]
      select_string += "GROUP BY #{options[:group_by]}"
    end
    if options[:having]
      select_string += "HAVING #{options[:having]}"
    end
    if options[:order_by]
      select_string += "ORDER BY #{options[:order_by]}"
    end
    if options[:limit]
      select_string += "LIMIT #{options[:limit]}"
      if options[:offset]
        select_string += "OFFSET #{options[:offset]}"
      end
    end

    puts select_string

    DB.fetch("#{select_string}") do |row|
      p row
    end
  end
end

# add methods with functions, count, conditions? (get specific rows of columns), group by (groups rows based on something)
# add where, group by, etc in the select_query using if statements

puts "Accessing table in database"
table = Functions.new()
table.name("comments")
# table.insert_row(options = [3, "John", "yep here", 2])
# table.add_column("rating", "INTEGER")
# table.drop
# table.create_table("comments", "id INTEGER PRIMARY KEY, name STRING, content TEXT")
puts table.select_query
