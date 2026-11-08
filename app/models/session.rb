class Session < ApplicationRecord
  LIFETIME = 14.days

  belongs_to :user

  scope :active, -> { where(expires_at: Time.current..) }

  before_validation :set_expiration, on: :create

  validates :expires_at, presence: true

  private
    def set_expiration
      self.expires_at ||= LIFETIME.from_now
    end
end
