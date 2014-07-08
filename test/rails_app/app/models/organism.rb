class Organism < ::ActiveRecord::Base
  has_many :toolings
  has_many :tools, through: :toolings
  validates :name, presence: true
end
