module Replication
  module StrandMethods

    def self.extended(strand_class)
      strand_class.class_eval do
        include InstanceMethods
      end
    end

    module InstanceMethods
      def replicate
        origin.new(pairs)
      end
    end
  end
end
