module Dropblog
  class Article < ActiveRecord::Base

    scope :draft, where(:published => false)
    scope :published, where(:published => true)

  end
end