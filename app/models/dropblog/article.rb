module Dropblog
  class Article < ActiveRecord::Base

    belongs_to :user

    scope :draft, where(:published => false)
    scope :published, where(:published => true)

  end
end