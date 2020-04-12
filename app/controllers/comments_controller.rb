# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_article
  before_action :find_commentable

  def index
    @comment = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    # @comment.save
    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@article), notice: 'Comment was successfully created.' }
        # format.json { render json: @comment, status: :created, location: @comment }
        # format.js { render :js => "console.log('#{@comment.to_json}');" }
        # format.js { render :js => "console.log('Hello, World!!!');" }
        # format.json { render json: @comment, status: :created, location: @comment }
      else
        format.js
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js {}
    end
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
