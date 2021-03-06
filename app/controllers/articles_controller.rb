# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  # GET /articles
  # GET /articles.json
  def index
    @pagy, @articles = pagy(Article.includes(:user).search(params[:search]), items: 10)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    # @comments = @article.comments.includes(:comments, :user)
    @comments = if params[:comment]
                  @article.comments.where(id: params[:comment])
                else
                  @article.comments.where(commentable_id: nil)
                end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = 'You can only edit or delete your own articles'
      redirect_to root_path
    end
  end
end
