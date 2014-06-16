class Organism < ::ActiveRecord::Base
  validates :name, presence: true
end
