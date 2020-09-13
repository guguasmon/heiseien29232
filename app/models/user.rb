class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :guests

  with_options presence: true do
    validates :name
    validates :email, uniqueness: { case_sensitive: true }, format: { with: /\A\S+@\S+\.\S+\z/ }
    validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'Password Include both letters and numbers' }
  end
end
