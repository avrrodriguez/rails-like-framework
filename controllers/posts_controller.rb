class PostsController < Controller
  def index
    @posts = Post.all
  end

  def show
    puts content
    puts "here2"
    @post = Post.find_by(id: params[:id])
  end
end
