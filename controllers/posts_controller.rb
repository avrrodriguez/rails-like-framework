class PostsController < Controller
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(id: params[:id])
  end

  def new
    @post = Post.new()
    puts "WE got here"
  end

  def create
    puts "Did we get here?"
    puts params
    @post = Post.create(
      title: params["title"],
      content: params["content"],
    )
    @action = "show"
  end
end
