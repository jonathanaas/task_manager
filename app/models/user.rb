class User < ApplicationRecord
    # Configuração do Devise
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    has_many :tasks
    #has_secure_password
    validates :email, presence: true, uniqueness: true
end