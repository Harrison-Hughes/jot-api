class ApplicationController < ActionController::API

  before_action :set_current_user

    def issue_token(payload)
        JWT.encode(payload, secret)
    end

    def decode_token(token)
        JWT.decode(token, secret)[0]
    end

    def get_token
        request.headers["Authorization"] || request.headers["Authorisation"]
    end

    def set_current_user
      token = get_token
      if token
        decoded_token = decode_token(token)
        @current_user = User.find(decoded_token["user_id"])
      else 
        @current_user = nil
      end
    end

    def logged_in?
        !!@current_user
    end

    def secret
      Rails.application.credentials.jwt
    end

end

  # def get_current_user
  #   id = decode_token["id"]
  #   User.find_by(id: id)
  # end

  # def decode_token
  #   begin
  #     JWT.decode(token, secret).first
  #   rescue
  #     {}
  #   end
  # end

  # def token
  #   request.headers["Authorization"] || request.headers["Authorisation"]
  # end

  # def issue_token(data)
  #   JWT.encode(data, secret)
  # end

  # def secret
  #   Rails.application.credentials.jwt
  # end