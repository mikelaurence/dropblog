module Dropblog
  module ArticlesHelper

    def dropblog_article_permalink_path(article, options = {})
      return dropblog_article_path(article) unless article.published?

      super article, { 
        :blog => article.blog,
        :year => article.published_at.year, 
        :month => article.published_at.month,
        :day => article.published_at.day,
        :permalink => article.permalink
      }.merge(options)
    end

    def post_time(article)
      return nil unless article.published_at

      if article.published_at + 1.day > Time.now
        'posted ' + time_ago_in_words(article.published_at) + ' ago'
      else
        'posted ' + article.published_at.to_s(Dropblog::Engine.config.published_at_format)
      end
    end

    def facebook_like_button(url)
      raw %[<iframe src="http://www.facebook.com/plugins/like.php?href=#{url}&amp;layout=button_count&amp;show_faces=true&amp;width=120&amp;action=like&amp;font&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:120px; height:21px;" allowTransparency="true"></iframe>]
    end
      
    def comments(url)
      case Dropblog::Engine.config.comments
      when :facebook
        app_id = nil
        raw %[<div id="fb-root"></div><script src="http://connect.facebook.net/en_US/all.js#appId=#{app_id}&amp;xfbml=1"></script><fb:comments href="#{url}" num_posts="5" width="500"></fb:comments>]
      end
    end

  end
end