module Replication
  module Modules
    module Association

      def self.included(model_class)
        model_class.accepts_nested_attributes_for *model_class.replication_config.options[:associations]
      end

      def strand_attributes
        super
        associations_to_replicate = self.class.replication_config.options[:associations]

        if associations_to_replicate
          if associations_to_replicate.last.class == Hash
            associations_to_replicate.pop
          end

          associations_to_replicate.each do |a|
            association_reflection = self.class.reflect_on_association(a)
            association_model = association_reflection.klass
            attributes_from_association = association_model.column_names.dup
            attributes_from_association.delete('id')
            attributes_from_association.delete(association_reflection.foreign_key)
            @strand_attributes.merge!({
              "#{a}_attributes".to_sym => self.send(association_reflection.name).select(attributes_from_association).to_a.map(&:serializable_hash)
            })
          end 
        end

        @strand_attributes
      end
    end
  end
end
