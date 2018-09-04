class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, and :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
end
