class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { case_sensitive: false },
                       presence: true,
                       allow_blank: false,
                       length: { maximum: 20 },
                       format: { with: /\A[a-zA-Z0-9]+\z/, message: ': only alphanumeric characters are allowed' }
  validates :bio, length: { maximum: 200 }
  validates :mobileNum, uniqueness: true,
                        format: { with: /\A[0-9]+\z/, message: ': only numbers are allowed' },
                        length: { in: 8..13 }, if: 'mobileNum.present?'

  has_many :requests, dependent: :destroy
  has_many :gifts, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy
  has_many :follows, as: :follower, dependent: :destroy

  acts_as_follower
  acts_as_followable

  def generate_jwt
    JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
                Rails.application.secrets.secret_key_base)
  end

  def wish(request)
    wishes.find_or_create_by(request: request)
  end

  def unwish(request)
    wishes.where(request: request).destroy_all

    request.reload
  end

  def wished?(request)
    wishes.find_by(request_id: request.id).present?
  end

end
