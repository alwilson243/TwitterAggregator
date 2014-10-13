class TweetsController < ApplicationController


  def home


    
  end

  def index


    unless current_user.nil?

      timeline_tweets = Tweet.get_timeline

      timeline_tweets.each do |tweet|
        
        # tries to save all timeline tweets to database, uniqueness required
        Tweet.create(name: tweet.user.name, text: tweet.text.split(" ")[1..-1].join(" "))
      end

      @timeline = Tweet.all
      
    end
  end

  def show
    # assume it starts with stream or fixed and a number, ie stream 100
    query = Tweet.find(params[:id]).text

    words = query.split(" ")
    type = words[0]
    min = words[1]

    query = words[2..-1].join(" ")

    results = Array.new
    results = type.downcase == "stream" ? Tweet.stream(query, min) : Tweet.read_recent(query, min)
    @length = results.length

    $word_map = Hash.new(0)

    results.each { |result|
      text = result.text.split(" ")
      text.each { |word|
        if word[0,1] == "@" or word[0,4] == "http" or word == "RT"
          text.delete(word)
        else
          word.downcase!
          $word_map[word] += 1
        end
      }
    }

    # if type.downcase == "stream"
    #   Tweet.stream(query, min)
    # else
    #   Tweet.read_recent(query, min)      
    # end
  


  end

 


    # unless current_user.nil?
    #   $word_map = Hash.new(0)
    #   @tweets = []
    #   for i in 0...9 # 9 -> 1000 tweets over 10 days
    #     @tweets += Tweet.read_recent("dota", (Time.now + 1.day - i.day).strftime("%Y-%m-%d"))
    #   end
    # end
end
