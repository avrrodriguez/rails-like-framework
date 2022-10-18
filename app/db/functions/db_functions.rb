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

    # get_schema
    f = File.open("/Users/abrahamrodriguez/Desktop/Actualize/framework/blog/app/db/schemas.rb", "a")
    table_data = schema
    f.write("\n")
    f.write("table name", " :#{@table_name}", "\n")
    table_data.each do |item|
      f.write(item[0], " ", item[1][:db_type], "\n")
    end

    f.close
  end
end

# add methods with functions, count, conditions? (get specific rows of columns), group by (groups rows based on something)
# might want to add to schema the ability to put in some other document the schema of tables currently in database (could add that to create table instead of schema)

puts "Accessing table in database"
table = Functions.new()
table.name("comments")
# table.drop
# table.create_table("comments", "id INTEGER PRIMARY KEY, name STRING, content TEXT")
# puts table.schema
