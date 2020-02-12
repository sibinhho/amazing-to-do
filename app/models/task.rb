class Task < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :search_by_name, 
      against: [:name, :user_id], using: {
      tsearch: { prefix: true }
    }

    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    has_and_belongs_to_many :tags
    
    VALID_DEADLINE_REGEXP = /[0-3]{1}[0-9]{1}\/[0-1]{1}[0-9]{1}\/[1-2]{1}[0-9]{3}/

    validates :deadline, format: { with: VALID_DEADLINE_REGEXP,
      message: "wrong date format" }
    validates :name, :category, presence: true

    # TO DO: Handle duplicate tasks
end
