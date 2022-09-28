class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action
  end

  def call
    send(action)
    self.status = 200
    self.headers = { "Content-Type" => "text/html" }
    if @action.to_s == "index"
      self.content = [template.render(self)]
    elsif @action.to_s == "show"
      self.content = [erb_file(self) { }]
    end
    self
  end

  def template
    Slim::Template.new(File.join(App.root, "app", "views", "#{self.name}", "#{self.action}.slim"))
  end

  def erb_file(context)
    file = File.read(File.join(App.root, "app", "views", "#{@name}", "#{@action}.html.erb"))
    ERB.new(file).result(binding)
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Nothing found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal error"]
  end
end
