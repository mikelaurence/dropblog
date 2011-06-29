require "dropblog"
require "rails"

module Dropblog
  class Engine < Rails::Engine
    paths.app.views << "../blogly/lib/blogly/views"

    config.title = 'Dropblog'
    config.description = 'A wonderful little blog'
    config.blogs = [:main]
    config.comments = :facebook
    config.published_at_format = :article
    config.link_to_user = false
    config.facebook_like = true
    config.excerpt_sentences = 3
    config.index_defaults = {
      :hide_comments => true,
      :excerpt => true
    }
    config.show_defaults = {
      :hide_comments => false,
      :excerpt => false
    }
    config.article_class = nil
    config.nav_class = nil

    config.to_prepare do
      ApplicationController.helper(ArticlesHelper)
    end
  end
end