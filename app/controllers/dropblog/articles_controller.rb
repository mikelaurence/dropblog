module Dropblog
  class ArticlesController < ApplicationController
    unloadable

    respond_to :html, :xml
    
    before_filter :get_blog, :only => [:index, :show]
    load_and_authorize_resource :class => 'Dropblog::Article', :except => :show

    def index
      validate_blog!

      @per_page ||= params[:per_page] || 10
      @articles = @articles.where(:blog => @blog)
      @articles = @articles.tagged_with(params[:tag].gsub('_', ' ')) if params[:tag]
      @articles = @articles.published unless can?(:edit, Article)
      @articles = @articles.order('published_at desc').page(params[:page]).per(@per_page)

      respond_to do |format|
        format.html
        format.xml { render :feed }
      end
    end

    def new
      @article.user = current_user
      @article.blog = Dropblog::Engine.config.blogs.first
      @article.allow_comments = true
    end

    def create
      if @article.update_attributes params[:dropblog_article]
        redirect_to @article
      else
        respond_with @article
      end
    end

    def show
      @article = Dropblog::Article.find(params[:id]) if params[:id]
      @article ||= Dropblog::Article.find_by_blog_and_permalink(params[:blog], params[:permalink])
      authorize! :read, @article

      @blog = @article.blog
      respond_with @article
    end
    
    def update
      if @article.update_attributes params[:dropblog_article]
        redirect_to @article
      else
        respond_with @article
      end
    end

    def publish
      @article.publish!
      redirect_to @article
    end

    def unpublish
      @article.unpublish!
      redirect_to @article
    end
    
    def destroy
      @article.destroy
      respond_with @article
    end



    protected

    def get_blog
      @blog = params[:blog]
    end

    def validate_blog!
      unless Dropblog::Engine.config.blogs.collect(&:to_s).include?(@blog)
        raise ActiveRecord::RecordNotFound.new("Couldn't find blog '#{@blog}'")
      end
    end

  end
end