Rails.application.routes.draw do |map|

  namespace :dropblog do
    resources :articles do
      member do
        get :publish
      end
    end
  end
  
  match 'blog/:blog' => 'dropblog/articles#index', :as => :dropblog_permalink
  match 'blog/:blog/:year/:month/:day/:permalink' => 'dropblog/articles#show', :as => :dropblog_article_permalink

end