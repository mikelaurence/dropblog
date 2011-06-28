module Dropblog
  class ArticlesController < ApplicationController
    unloadable

    respond_to :html
    
    load_and_authorize_resource :class => 'Dropblog::Article', :except => :show

    def index
      @per_page ||= params[:per_page] || 10
      @articles = @articles.published unless can?(:edit, Article)
      @articles = @articles.order('published_at desc').paginate :page => params[:page], :per_page => @per_page
    end

    def new
      @article.user = current_user
      @article.blog = Dropblog::Engine.config.blogs.first
      @article.allows_comments = true
    end

    def create
      if @article.update_attributes params[:dropblog_article]
        redirect_to @article
      else
        respond_with @article
      end
    end

    def show
      @article = Dropblog::Article.find_by_permalink(params[:permalink])
      authorize! :read, @article
      respond_with @article
    end
    
    def update
      if @article.update_attributes params[:dropblog_article]
        redirect_to @article
      else
        respond_with @article
      end
    end
    
    def destroy
      @article.destroy
      respond_with @article
    end

  end
end