require "dropblog"
require "rails"

module Dropblog
  class Engine < Rails::Engine
    paths.app.views << "../blogly/lib/blogly/views"

    Time::DATE_FORMATS[:article] ||= "%A, %B %d, %Y at %H:%M%p"

    config.blogs = [:main]
    config.comments = :facebook
    config.published_at_format = :article
    config.facebook_like = true

    config.to_prepare do
      ApplicationController.helper(ArticlesHelper)
    end
  end
end