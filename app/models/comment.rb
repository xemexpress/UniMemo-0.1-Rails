class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request

  validates :body, presence: true,
                   allow_blank: false,
                   length: { maximum: 100 }
end
