class PostsController < Controller
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(id: params[:id])
  end

  def new
    @post = Post.new()
  end

  def create
    @post = Post.create(
      title: params["title"],
      content: params["content"],
    )
    @action = "show"
  end

  def delete
    @post = Post.find(id: params[:id])
    @post.destroy

    @action = "index"
    @posts = Post.all
  end

  def update
    @post = Post.find(id: params[:id])
    @post.title = params["title"]
    @post.content = params["content"]
    @post.save

    @action = "index"
    @posts = Post.all
  end
end
