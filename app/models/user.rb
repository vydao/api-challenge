class User < ActiveRecord::Base
  before_create :set_authentication_token!

  validates :name, presence: true, uniqueness: true

  private

  def set_authentication_token!
    return if auth_token.present?
    self.auth_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.uuid.gsub(/\-/,'')
      break token unless self.class.exists?(auth_token: token)
    end
  end
end
