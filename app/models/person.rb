class Person < ApplicationRecord
  has_many :roles
  has_many :companies, through: :roles

  def full_name
    "#{last_name}, #{first_name}"
  end
end
