class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(env)
    path = env["REQUEST_PATH"]
    puts path
    params = {}
    if routes.key?(path)
      ctrl(routes[path], params).call
    elsif path[-1].to_i.integer?
      params[:id] = path[-1].to_i
      ctrl(routes["#{path[0..-3]}/:id"], params).call
    else
      Controller.new.not_found
    end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error
  end

  private def ctrl(string, params)
    ctrl_name, action_name = string.split("#")

    klass = Object.const_get("#{ctrl_name.capitalize}Controller")
    klass.new(name: ctrl_name, action: action_name.to_sym, params: params)
  end
end
