class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user # so views can use it

 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
        



  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_secret = auth.credentials.secret
  #     user.save!
  #   end
  # end


    
end