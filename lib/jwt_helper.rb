# lib/jwt_helper.rb

module JwtHelper
  extend ActiveSupport::Concern

 # Secret key from .env
 JWT_SECRET = ENV["JWT_SECRET_KEY"]

 # Encode JWT token with expiration
 def encode_token(payload)
   payload[:exp] = 24.hours.from_now.to_i
   JWT.encode(payload, JWT_SECRET, "HS256")
 end

 # Decode JWT token
 def decode_token(token)
   begin
     decoded = JWT.decode(token, JWT_SECRET, true, algorithm: "HS256")[0]
     HashWithIndifferentAccess.new(decoded)
   rescue JWT::DecodeError
     nil
   end
 end
end
