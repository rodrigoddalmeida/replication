module Replication
  module Modules
    module Polymorphic
      def self.included(model_class)
        model_class.class_eval do
          has_many :strands, class_name: replication_config.strand_class,
                             as: :origin
        end
      end
    end
  end
end
