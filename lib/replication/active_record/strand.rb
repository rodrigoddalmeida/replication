require "orm_adapter/adapters/active_record"

module Replication
  module ActiveRecord
    class Strand < ::ActiveRecord::Base
      extend Replication::StrandMethods
      serialize :pairs
      belongs_to :origin

      validates :name, uniqueness: true, presence: true
    end
  end
end
