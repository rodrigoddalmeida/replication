class Tool < ActiveRecord::Base
  has_many :toolings
  has_many :organisms, through: :toolings
end
