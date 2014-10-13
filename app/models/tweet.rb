class Tweet < ActiveRecord::Base

  before_save {self.name = name.downcase}
  before_save {self.text = text.downcase}

  validates :name, presence: true
  validates :text, presence: true, uniqueness: { case_sensitive: false }


  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key        = Rails.application.config.twitter_key
    config.consumer_secret     = Rails.application.config.twitter_secret
    config.access_token        = Rails.application.config.omniauth_token
    config.access_token_secret = Rails.application.config.omniauth_secret 
  end

  def self.get_timeline

    timeline = @@client.mentions_timeline
    
  end

  def self.stream(query, min)
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = Rails.application.config.omniauth_token
      config.access_token_secret = Rails.application.config.omniauth_secret 
    end

    count = 0
    results = Array.new

    list = client.filter(:track => query) do |o|
      break if count == min.to_i
      puts o
      puts count
      results.push(o)
      count += 1
    end

    return results

  end



  def self.read_recent(topic, min)
    min = min.to_i
    iterations = min % 100 == 0 ? min/100 : min/100 + 1

    results = Array.new

    for i in 0...iterations
      time = (Time.now + 1.day - i.day).strftime("%Y-%m-%d")
      result = @@client.search(topic, :lang => "en", :count => 100, :until => time)
      results += result.instance_variable_get(:@collection)
    end

    return results
##########################################

    # query = @@client.search(topic, :lang => "en", :count => 100, :until => time)
    # tweets = query.instance_variable_get(:@collection)

    # tweets.each { |tweet| 
    #   text = tweet.text.split(" ")
    #   text.each { |word|
    #     if word[0,1] == "@" or word[0,4] == "http" or word == "RT"
    #       text.delete(word)
    #     else
    #       word.downcase!
    #       $word_map[word] += 1
    #       # put word into some global data structure
    #     end
    #   }
    # }

    # return tweets
    # clean input - remove "RT", remove @...:, remove "http..."

  end

end

