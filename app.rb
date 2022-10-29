require "yaml"
require "./lib/router"

ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), "app", "routes.yml")))

# Creating database context
db_config_file = File.join(File.dirname(__FILE__), "app", "database.yml")
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

# Connecting all our framework's classes
Dir[File.join(File.dirname(__FILE__), "lib", "*.rb")].each { |file| require file }

# Connecting framework controllers
Dir[File.join(File.dirname(__FILE__), "controllers", "**", "*.rb")].each { |file| require file }

# If there is a database connection, running all the migrations
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), "app", "db", "migrations"), :use_transactions => false)
end

# DB functions
Dir[File.join(File.dirname(__FILE__), "app", "**", "db_functions.rb")].each {
  |file|
  require file
}

# Connecting controllers to database
Dir[File.join(File.dirname(__FILE__), "app", "models", "**.rb")].each {
  |file|
  require file
}

# Addings posts after post controller is connected to database
# Dir[File.join(File.dirname(__FILE__), "app", "**", "add_posts.rb")].each { |file| require file }

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end

  def self.root
    File.dirname(__FILE__)
  end
end
