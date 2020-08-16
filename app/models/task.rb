class Task < ApplicationRecord
    validates :name, presence: true, length: { maximum: 140 }
    validates :detail, presence: true,length: { maximum: 500 }

end
