class AuthenticationController < ApplicationController
    def register
      user = User.new(user_params)
      if user.save
        render json: { message: 'Usuário criado com sucesso' }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def login
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        token = encode_token(user.id)
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Credenciais inválidas' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :password)
    end
  
    def encode_token(user_id)
      JWT.encode({ user_id: user_id, exp: (Time.now + 24.hours).to_i }, 'secreta')
    end
end
  