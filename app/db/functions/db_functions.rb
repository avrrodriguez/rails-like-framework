require "sequel"

class Functions
  def name(table_name)
    @table_name = table_name
  end

  def create_table(table_name, *options)
    db_new_table = "CREATE TABLE #{table_name} (#{options})"
    DB.run "#{db_new_table}"
    puts "#{table_name} table created"
  end

  def drop
    DB.drop_table @table_name.to_sym
  end

  def join(table1, table1_column, table2, table2_matching_column)
    db_join_tables = "SELECT * FROM #{table1} INNER JOIN #{table2} ON #{table1_column}=#{table2_matching_column}"
  end

  def get_schema
    puts DB.schema(@table_name.to_sym)
  end
end

puts "Accessing table in database"
table = Functions.new()
table.name("comments")
table.get_schema
