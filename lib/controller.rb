class Controller
  attr_reader :name, :params
  attr_accessor :status, :headers, :content, :action

  def initialize(name: nil, action: nil, params: nil)
    @name = name
    @action = action
    @params = params
  end

  def call
    send(action)
    self.status = 200
    self.headers = { "Content-Type" => "text/html" }
    self.content = [erb_file(self) { }]

    self
  end

  def erb_file(content)
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

  def redirect_to(path)
    @action = path
    @posts = Post.all
  end

  def form_with(url, method)
    "<form action=#{url} method='post'> 
      <input name='_method' type='hidden' value='#{method}' />"
  end

  def form_end
    "</form>"
  end
end
