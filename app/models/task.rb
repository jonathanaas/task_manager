class Task < ApplicationRecord
    belongs_to :user
    validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
    validates :status, inclusion: { in: %w(pendente em_progresso concluída falha) }
end
  