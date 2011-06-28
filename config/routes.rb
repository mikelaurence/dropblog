Rails.application.routes.draw do |map|

  resources :articles, :controller => 'dropblog/articles'
  
  match 'blog/:blog' => 'dropblog/articles#index', :as => :blog_permalink
  match 'blog/:blog/:year/:month/:permalink' => 'dropblog/articles#show', :as => :article_permalink

end