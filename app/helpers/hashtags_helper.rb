module HashtagsHelper
  def auto_link_hashtags(message)
    message.gsub(/#[[:alpha:]][[[:alnum:]]-]*/) do |hashtag|
      name = hashtag[1..-1]
      link_to hashtag, hashtag_path(Hashtag.find(name))
    end
  end
end
