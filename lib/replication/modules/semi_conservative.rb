module Replication
  module Modules
    module SemiConservative

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
