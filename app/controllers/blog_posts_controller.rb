class BlogPostsController < ApplicationController
  include ActiveStorage::SetCurrent

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :set_all_tags, only: [:show, :index]
  def index
    @blog_posts = user_signed_in? ? BlogPost.all.sorted : BlogPost.published.sorted
    if params[:tag].present?
      @blog_posts = @blog_posts.tagged_with(params[:tag])
    end
    @pagy, @blog_posts = pagy(@blog_posts, items: 21)
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to @blog_post, notice: 'Blog post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, notice: 'Blog post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @blog_post.destroy
      redirect_to root_path, notice: 'Blog post was successfully destroyed.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_all_tags
    @all_tags = ActsAsTaggableOn::Tag.all.order(name: :asc)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.friendly.find(params[:id]) : BlogPost.friendly.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def blog_post_params
    params.require(:blog_post).permit(
      :body,
      :description,
      :header_image,
      :published_at,
      :tag_list,
      :title
    )
  end
end
