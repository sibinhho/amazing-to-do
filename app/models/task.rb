class Task < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :search_by_name, 
      against: [:name, :user_id], using: {
      tsearch: { prefix: true }
    }

    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    has_and_belongs_to_many :tags
end
