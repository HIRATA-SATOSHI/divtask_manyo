class Task < ApplicationRecord
    # default_scope { order(created_at: :desc)}
    validates :name, presence: true, length: { maximum: 140 }
    validates :detail, presence: true,length: { maximum: 500 }
    validates :deadline, presence: true
    enum status:{ not_yet: 0, in_progress: 1, completed: 2 }
    enum priority: { high: 0, middle: 1, low: 2 }

end
