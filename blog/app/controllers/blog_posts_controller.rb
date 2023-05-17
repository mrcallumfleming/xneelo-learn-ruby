class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :destroy, :update, :edit]
  after_action :log_out
  def index
    # Instance variable
    @blog_posts = BlogPost.all
  end

  def show
  rescue ActiveRecord::RecordNotFound
    # logging here
    return redirect_to root_path
  end

  def new
    # this will help generate a form
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      # this will only render the template, uses @blog_post from create function
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find params[:id]
  rescue ActiveRecord::RecordNotFound
    # meaningful logging goes here
    puts "General FAILURE: Post not found #{params[:id]}"
    redirect_to root_path
  end

  def log_out
    # p self
    # p self.view_context[]
    puts "Route ENDS"
  end
end