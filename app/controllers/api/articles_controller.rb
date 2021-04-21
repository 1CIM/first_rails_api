class Api::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles }
  end

  def show
    article = Article.find(params['id'])
    render json: { article: article }, status: 200
  end

  # RecordNotFound is raised when ActiveRecord cannot find record by given id or set of ids
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { message: 'Unfortunately we can not find the article you are looking for.' }, status: 404
  end
end
