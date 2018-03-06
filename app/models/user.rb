class User < ApplicationRecord

validates :email,:first_name,:last_name,:password,presence: true
validates :password , length: {minimum:6}
validates :email , uniqueness: {message: "This email : %{value} already exists" }
  has_secure_password
  has_many :rental

end
