module Dropblog
  class ArticlesController < ApplicationController

    unloadable
    
    load_and_authorize_resource :class => 'Dropblog::Article', :except => :show
    after_filter :respond, :except => :index

    def index
      @per_page ||= params[:per_page] || 10
      @articles = @articles.published.order('published_at desc').paginate :page => params[:page], :per_page => @per_page
    end

    def create
      @article.update_attributes params[:article]
    end

    def show
      @article = Dropblog::Article.find_by_permalink(params[:permalink])
      authorize! :read, @article
    end
    
    def update
      @article.update_attributes params[:article]    
    end
    
    def destroy
      @article.destroy
    end 



    private

    def respond
      respond_with @article
    end

  end
end