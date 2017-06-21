class Request < ApplicationRecord
  belongs_to :poster, :class_name => "User"
  belongs_to :helper, :class_name => "User"
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy

  acts_as_followable

  scope :posted_by, ->(username) { where(poster: User.where(username: username)) }
  scope :helped_by, ->(username) { where(helper: User.where(username: username)) }
  scope :wished_by, ->(username) { joins(:wishes).where(wishes: { user: User.where(username: username) }) }
  scope :expired, -> { where("end_time < ?", Time.now) }
  scope :old, -> { where("end_time < ?", Time.now - 14.days) }

  acts_as_taggable

  validates :tag_list, presence: true, allow_blank: false
  validates :end_time, presence: true, allow_blank: false
  validates :end_place, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false, length: { maxium: 100 }
end
