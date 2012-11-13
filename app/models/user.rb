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

  before_save :create_remember_token

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

  private # Only internal user needs access to following code.

     def create_remember_token
       # Using the urlsafe-base64 method from the SecureRandom module
       # in the Ruby standard library, creates a Base64 string safe 
       # for use in URIs, hence safe for use in cookies.
       # Returns a random string of length 16 composed of A-Z, a-z, 0-9,
       # - and _.
       self.remember_token = SecureRandom.urlsafe_base64
     end

end
