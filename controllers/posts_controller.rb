class PostsController < Controller
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(id: params[:id])
  end

  def create
    @post = Post.create(
      title: params[:title],
      content: params[:content],
    )
  end
end
