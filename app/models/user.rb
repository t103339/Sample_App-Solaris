class User < ActiveRecord::Base

  attr_accessible :email, 
                  :name,
                  :password,
                  :password_confirmation

  # The method "has_secure_password"
  # This adds password and password_confirmation attributes,
  # require the presence of the password, require that they
  # match and add an authenticate method to compare encrypted 
  # password to the password_digest to authenticate users.
  # Note: password_digest column must exist in database table.
  has_secure_password

  #before_save { |user| user.email = email.downcase }
  before_save { self.email.downcase! }

  validates( :name, presence: true, 
                    length: { maximum: 50 }
           )

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX } 
           )

  validates( :password, presence: true, 
                        length: { minimum: 6 })
  validates( :password_confirmation, presence: true)

end
