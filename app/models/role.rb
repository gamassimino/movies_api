class Role < ApplicationRecord
  belongs_to :movie
  belongs_to :person

  enum role: { actor: 0, director: 1, producer: 2 }

  scope :actors, -> { where(role: :actor) }
  scope :directors, -> { where(role: :director) }
  scope :producers, -> { where(role: :producer) }
end
