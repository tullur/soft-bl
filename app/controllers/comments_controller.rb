# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article
  before_action :find_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      format.js if @comment.save
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_commentable
    if params[:article_id]
      @commentable = Article.find_by_id(params[:article_id])
    end
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
