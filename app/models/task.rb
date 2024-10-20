class Task < ApplicationRecord
    belongs_to :user
  
    validates :title, presence: true
    validates :status, inclusion: { in: %w(pendente em_progresso concluída falha) }
    validates :url, format: { with: URI::regexp(%w[http https]) }
end
  