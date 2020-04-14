# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article
  before_action :find_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js
        # format.html { redirect_to @commentable }
        # format.html { redirect_to article_path(@article), notice: 'Comment was successfully created.' }
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user

    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_commentable
    @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
