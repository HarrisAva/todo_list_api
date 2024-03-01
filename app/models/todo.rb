class Todo < ApplicationRecord
    validates :body, presence: true, length: {maximum: 255}
    validates :is_completed, inclusion: {in: [true, false]}

    belongs_to :user
end
