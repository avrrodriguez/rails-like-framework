use Rack::MethodOverride

require "rubygems"
require "bundler"
Bundler.require

require "./app"

run App.new
