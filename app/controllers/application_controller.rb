class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    token = request.headers['Authorization'].split(' ').last
    @current_user = User.find(decoded_token[:user_id]) if decoded_token
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'Não autorizado' }, status: :unauthorized
  end

  def decoded_token
    JWT.decode(token, 'secreta')[0]
  end

end
