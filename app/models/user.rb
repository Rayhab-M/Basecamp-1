class User < ApplicationRecord
  has_and_belongs_to_many :projects
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add a method to check admin status
  def admin?
    admin
  end
end
