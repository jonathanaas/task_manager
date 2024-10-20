class ApplicationController < ActionController::Base
  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, 'your_secret_key')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      User.find_by(id: user_id)
    end
  end

  def authenticate_user!
    render json: { error: 'Não autorizado' }, status: :unauthorized unless current_user
  end
end
