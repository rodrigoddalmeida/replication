module Replication
  module Process

    def self.extended(model_class)
      model_class.class_eval do
        @@replication_config = Class.new(Config).new(self)
        include Model
      end
    end

    # Include or extend it. We work with both.
    def self.included(model_class)
      model_class.extend self
    end

    def can_replicate(pairs_method = :attributes, **options)
      default_options = Replication.defaults
      modules = [:semi_conservative] # required module
      modules.concat(Array(options.delete(:with)))

      @@replication_config.pairs_method = pairs_method
      @@replication_config.set default_options.merge(options)
      @@replication_config.with modules
    end

    def new_from_strand(id=nil, **options)
      if id
        strand = replication_config.strand_class.to_adapter.get!(id)
      else
        strand = replication_config.strand_class.to_adapter.find_first(options)
      end

      new(strand.pairs) if strand
    end

    def replication_config
      @@replication_config
    end

    module Model

      def strand_class
        replication_config.strand_class
      end

      def replication_config
        self.class.replication_config
      end

      private

        def _strand_attributes
          send(replication_config.pairs_method).deep_symbolize_keys
        end
    end
  end
end
