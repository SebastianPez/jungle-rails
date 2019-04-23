class User < ActiveRecord::Base
	has_secure_password

	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true

	def self.authenticate_with_credentials email, password
		stripped_email = email.strip
		if User.find_by(email: stripped_email.downcase).try(:authenticate, password)
			User.find_by(email: stripped_email.downcase)
		else
			nil
		end
	end

end
