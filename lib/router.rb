class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(env)
    path = env["REQUEST_PATH"]
    method = env["REQUEST_METHOD"]

    puts env

    if path.length > 1
      path_arr = path.scan(/(\/)(\w+)/)
      route_path = path_arr[0][0] + path_arr[0][1]
    end

    params = {}

    if routes.key?(path)
      ctrl(routes[path].select { |value| value[method] }[0][method], params).call
    elsif path_arr[1]
      params[:id] = path_arr[1][1].to_i
      ctrl(routes["#{route_path}/:id"][0][method], params).call
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
