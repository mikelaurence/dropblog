require 'redcarpet'

module Dropblog
  class Article < ActiveRecord::Base

    belongs_to :user

    scope :draft, where(:published => false)
    scope :published, where(:published => true)

    validates_presence_of :user
    validates_presence_of :blog
    validates_presence_of :title
    validates_presence_of :body

    before_validation :set_default_permalink

    def html
      Redcarpet.new(body).to_html
    end




    protected

    def set_default_permalink
      self.permalink = title.parameterize if self.permalink.blank?
    end

  end
end