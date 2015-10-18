class AdminUser < ActiveRecord::Base

	#To configure a difference table name:
	#self.table_name = "admin_users"

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	FORBIDDEN_USERNAME =['littlebopeep','humptydumpty','marymary']




	validates_presence_of :first_name
	validates_length_of :first_name, :maximum => 25
	validates_presence_of :last_name
	validates_length_of :last_name, :maximum => 50
	validates_presence_of :username
	validates_length_of :username, :within => 8..25
	validates_uniqueness_of :username
	validates_presence_of :email
	validates_length_of :email, :maximum =>100
	validates_format_of :email, :with => EMAIL_REGEX
	validates_confirmation_of :email


	validate :username_is_allowed
	#validate :no_new_users_on_saturday, :on => :create


	def no_new_users_on_saturday
		if Time.now.wday == 6
			errors[:base] << "No new users on Saturdays"
		end
	end

	def username_is_allowed
		if FORBIDDEN_USERNAME.include?(username)
			errors.add(:username, "has been restreictes from use.")
		end
	end
end
