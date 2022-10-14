require "sequel"

class Functions
  # def initialize(*table)
  #   if table
  #     @dataset = DB[:"#{table}"]
  #   end
  # end

  def create_table(table_name, options = {})
    db_new_table = "CREATE TABLE #{table_name} (#{options[:name]} #{options[:name_type]} #{:comment} #{:comment_type})"
    DB.run "#{db_new_table}"
    puts "#{table_name} table created"
  end

  def join(table1, table2)
  end
end

puts "Creating new table in database"
table = Functions.new()
table.create_table("comments", { name: "name", name_type: "string", comment: "comment", comment_type: "text" })
