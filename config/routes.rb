Rails.application.routes.draw do |map|
  match 'blog/:blog' => 'dropblog/articles#index'
  match 'blog/:blog/:year/:month/:permalink' => 'dropblog/articles#show'
end