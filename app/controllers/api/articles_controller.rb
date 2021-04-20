class Api::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles }
    binding.pry
  end

  def show
    article = Article.find(params['id'])
    render json: { article: article }, status: 200
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { message: 'Unfortunately we can not find the article you are looking for.' }, status: 404
  end
end
