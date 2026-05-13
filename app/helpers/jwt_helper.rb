module JwtHelper
  
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def self.encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  
  def self.decode_token(token)
    JWT.decode(token, SECRET_KEY)[0]
  rescue JWT::DecodeError
    nil
  end
end
