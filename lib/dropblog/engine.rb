require "dropblog"
require "rails"

module Dropblog
  class Engine < Rails::Engine
    paths.app.views << "../blogly/lib/blogly/views"
  end
end