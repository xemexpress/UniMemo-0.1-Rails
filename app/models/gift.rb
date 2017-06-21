class Gift < ApplicationRecord
  belongs_to :provider, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  scope :related_to, -> (user_id) { where(provider_id: user_id).or(Gift.where(receiver_id: user_id)) }
  scope :tagged, -> (gift_id_list) { where(gift_id: gift_id_list) }
  scope :expired, -> { where("expire_at < ?", Time.now) }
  scope :provided_by, -> (username) { where(provider: User.where(username: username)) }
  scope :received_by, -> (username) { where.not(provider: User.where(username: username)) }

  acts_as_taggable

  validates :tag_list, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false, length: { maxium: 100 }
  #validate :last_for_at_least_three_days?

  def last_for_at_least_three_days?
    return true if expire_at.presence && expire_at > Time.now + 3.days
    errors.add(:expire_at, "should be at least 3 days after today")
    return false
  end
end
