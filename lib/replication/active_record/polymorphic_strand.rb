module Replication
  module ActiveRecord
    class PolymorphicStrand < Strand
      belongs_to :origin, polymorphic: true
    end
  end
end
