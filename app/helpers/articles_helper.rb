module Dropblog
  module ArticlesHelper

    def facebook_like_button(url)
      %[<iframe src="http://www.facebook.com/plugins/like.php?href=#{url}&amp;layout=button_count&amp;show_faces=true&amp;width=120&amp;action=like&amp;font&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:120px; height:21px;" allowTransparency="true"></iframe>]
    end
      
    def comments(url)
      case Rails.configuration.dropblog.comments || :facebook
      when :facebook
        app_id = nil
        %[<div id="fb-root"></div><script src="http://connect.facebook.net/en_US/all.js#appId=#{app_id}&amp;xfbml=1"></script><fb:comments href="#{url}" num_posts="5" width="500"></fb:comments>]
      end
    end

  end
end