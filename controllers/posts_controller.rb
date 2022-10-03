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
    redirect_to "show"
  end

  def delete
    @post = Post.find(id: params[:id])
    @post.destroy

    redirect_to "index"
  end

  def edit
    @post = Post.find(id: params["id"])
  end

  def update
    @post = Post.find(id: params[:id])
    @post.title = params["title"] || @post.title
    @post.content = params["content"] || @post.content
    @post.save

    redirect_to "index"
  end
end
