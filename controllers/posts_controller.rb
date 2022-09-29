class PostsController < Controller
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(id: params[:id])
  end
end
