require 'active_support/core_ext/hash/except'
require 'active_support/core_ext/hash/slice'

module Replication
  module Modules
    module SemiConservative

      def unwound(**options)
        strand_class.new({
          name: options[:name],
          pairs: strand_attributes,
          origin_id: self.id,
          origin_type: self.class.to_s
        })
      end

      def replicate(**options)
        strand_class.to_adapter.create!({
          name: options[:name],
          pairs: strand_attributes,
          origin_id: self.id,
          origin_type: self.class.to_s
        })
      end

      def strand_attributes
        @strand_attributes = _strand_attributes
        @strand_attributes = @strand_attributes.slice(*replication_config.only) unless replication_config.only.empty?
        @strand_attributes = @strand_attributes.except(*replication_config.except) unless replication_config.except.empty?
      end
    end
  end
end
