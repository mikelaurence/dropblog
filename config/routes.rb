Rails.application.routes.draw do |map|

  namespace :dropblog do
    resources :articles do
      member do
        get :publish
        get :unpublish
      end
    end
  end

  match 'blog' => 'dropblog/articles#index'
  match 'blog/:blog' => 'dropblog/articles#index', :as => :dropblog_permalink
  match 'blog/:blog/:year/:month/:day/:permalink' => 'dropblog/articles#show', :as => :dropblog_article_permalink
  match 'blog/:blog/:tag' => 'dropblog/articles#index', :as => :dropblog_tag

end