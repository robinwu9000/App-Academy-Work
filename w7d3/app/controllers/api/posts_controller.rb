# module Api
class Api::PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    render json: Post.all
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def index
    render json: Post.all
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end
end

# end
