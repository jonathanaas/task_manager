class AuthenticationController < ApplicationController
  before_action :authenticate_user!, only: [:login, :register]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Credenciais inválidas' }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)
    if user.save
      render json: { message: 'Usuário criado com sucesso.' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secrets.secret_key_base)
  end
end
