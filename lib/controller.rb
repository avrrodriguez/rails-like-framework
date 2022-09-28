class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil, id: nil)
    @name = name
    @action = action
    @id = id
  end

  def call
    send(action)
    self.status = 200
    self.headers = { "Content-Type" => "text/html" }
    self.content = [erb_file(self) { }]

    self
  end

  def erb_file(content)
    puts @id
    puts @name
    puts @action
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
