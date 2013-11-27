class User < ActiveRecord::Base
	has_one :collection, dependent: :destroy

	has_secure_password

	before_create :generate_auth_token 

	validates :first_name, 	presence: true
	validates :last_name, 	presence: true
	validates :username, 		presence: true, 
													uniqueness: true,
													length: { minimum: 3 }
	validates :email, 			presence: true,
													uniqueness: { case_sensitive: false },
													format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
	validates :password,    length: { minimum: 6 } , :if => :password_digest_changed?

	def send_password_reset
		generate_password_reset_token
		self.password_sent_at = Time.now
		save!
		UserPasswordReset.password_reset(self).deliver
	end

	def generate_auth_token
		begin
			self.auth_token = SecureRandom.urlsafe_base64
		end while User.exists?(auth_token: self.auth_token)
	end

	def generate_password_reset_token
		begin
			self.password_reset_token = SecureRandom.urlsafe_base64
		end while User.exists?(password_reset_token: self.password_reset_token)
	end
end
