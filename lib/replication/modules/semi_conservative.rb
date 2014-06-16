module Replication
  module Modules
    module SemiConservative

      def self.extended(model_class)
        model_class.class_eval do
          include Model
        end
      end

      module Model

        def unwound(**options)
          strand_class.new({
            name: options[:name],
            pairs: strand_attributes,
            origin: self
          })
        end

        def replicate(**options)
          strand_class.to_adapter.create!({
            name: options[:name],
            pairs: strand_attributes,
            origin: self
          })
        end

        def strand_attributes
          _strand_attributes.except(*replication_config.except)
        end
      end
    end
  end
end
