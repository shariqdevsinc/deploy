# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]

  def index
    @posts = Post.published
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @post.destroy

    redirect_to root_path, notice: 'Post was successfully destroyed.'
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_back(fallback_location: posts_path)
  end

  private

  def set_post
    @post = Post.with_attached_files.find_by(id: params[:id])
    if @post.nil?
      redirect_to root_path, notice: 'Wrong parameters passed'
    else
      status_check
    end
  end

  def status_check
    current = Post.find_by(id: params[:id])
    redirect_to root_path, notice: 'Post has not been approved yet/putted down' unless current.published?
  end

  def post_params
    params.require(:post).permit(:title, :body, files: [])
  end
end
