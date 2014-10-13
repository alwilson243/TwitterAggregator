class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  # moved to tweet model
  # @@client = Twitter::REST::Client.new do |config|
  #   config.consumer_key        = Rails.application.config.twitter_key
  #   config.consumer_secret     = Rails.application.config.twitter_secret
  #   config.access_token        = Rails.application.config.omniauth_token
  #   config.access_token_secret = Rails.application.config.omniauth_secret 
  # end

  



end




  # def read(user)
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = Rails.application.config.twitter_key
  #     config.consumer_secret     = Rails.application.config.twitter_secret
  #     config.access_token        = Rails.application.config.omniauth_token
  #     config.access_token_secret = Rails.application.config.omniauth_secret 
  #   end

  #   timeline = client.user_timeline(user)
  #   client.follow("charliecbsun")
  # end

  # def screen_name
  #   client = Twitter::REST::Client.new do |config|
  #   config.consumer_key        = Rails.application.config.twitter_key
  #   config.consumer_secret     = Rails.application.config.twitter_secret
  #   config.access_token        = Rails.application.config.omniauth_token
  #   config.access_token_secret = Rails.application.config.omniauth_secret 
  #   end
  #   return client.user.screen_name
  # end



  # def tweet(tweet)
    # client = Twitter::REST::Client.new do |config|
    #   config.consumer_key        = Rails.application.config.twitter_key
    #   config.consumer_secret     = Rails.application.config.twitter_secret
    #   config.access_token        = oauth_token
    #   config.access_token_secret = oauth_secret
  #   # end
  #   client.update(tweet)
  # end

  # def collect_with_max_id(collection=[], max_id=nil, &block)
  #   response = yield(max_id)
  #   collection += response
  #   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  # end

  # def client.get_all_tweets(user)
  #   collect_with_max_id do |max_id|
  #     options = {:count => 200, :include_rts => true}
  #     options[:max_id] = max_id unless max_id.nil?
  #     user_timeline(user, options)
  #   end
  # end
  #client.get_all_tweets("alwilson243")


