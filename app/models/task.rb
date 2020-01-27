class Task < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    has_and_belongs_to_many :tags
end
