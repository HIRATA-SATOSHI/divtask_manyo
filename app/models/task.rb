class Task < ApplicationRecord
    default_scope { order(created_at: :desc)}
    validates :name, presence: true, length: { maximum: 140 }
    validates :detail, presence: true,length: { maximum: 500 }
    validates :deadline, presence: true

end
