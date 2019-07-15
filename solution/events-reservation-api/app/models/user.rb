class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true

  has_secure_token :token

  def admin?
    role == 'admin'
  end

  def after_updated_psd(password)
    authenticate(password)
    regenerate_token
  end
end
