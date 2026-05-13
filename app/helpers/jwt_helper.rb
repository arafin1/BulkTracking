module JwtHelper
  def self.secret_key
    # This evaluates dynamically on every request rather than freezing at boot
    ENV['SECRET_KEY_BASE'] || Rails.application.credentials.secret_key_base
  end

  def self.encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, secret_key)
  end

  def self.decode_token(token)
    # Uses the dynamic secret key structure
    decoded_array = JWT.decode(token, secret_key)
    decoded_array[0]
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Failed: #{e.message}"
    nil
  end
end
