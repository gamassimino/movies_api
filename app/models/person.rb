class Person < ApplicationRecord
  has_many :roles
  has_many :companies, through: :roles
end
