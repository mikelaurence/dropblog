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
    validates_uniqueness_of :permalink

    acts_as_taggable_on :tags

    before_validation :set_default_permalink

    def html
      to_html body
    end

    def excerpt_html
      if excerpt.blank?
        to_html body.sentences.first(Dropblog::Engine.config.excerpt_sentences).join
      else
        to_html excerpt
      end
    end

    def publish!
      self.update_attribute :published, true
    end

    def unpublish!
      self.update_attribute :published, false
    end



    protected

    def to_html(content)
      Redcarpet.new(content).to_html
    end

    def set_default_permalink
      self.permalink = title.parameterize if self.permalink.blank?
    end

  end
end