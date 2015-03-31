module Replication
  module Process

    def can_replicate(pairs_method = :attributes, **options)
      reset_config if self.respond_to?(:unwound)

      puts replication_config.inspect

      default_options = Replication.defaults
      modules = [:semi_conservative] # required module
      modules.concat([].push(options.delete(:with)).flatten).compact!

      replication_config.pairs_method = pairs_method
      replication_config.set default_options.merge(options)
      replication_config.with modules

      include Model
    end

    def new_from_strand(id=nil, **options)
      if id
        strand = replication_config.strand_class.to_adapter.get!(id)
      else
        strand = replication_config.strand_class.to_adapter.find_first(options)
      end

      new(strand.pairs) if strand
    end

    def reset_config
      @replication_config = nil
    end

    def replication_config
      @replication_config ||= base_class.replication_config.dup.tap do |config|
        config.model_class = self
      end
    end
  end

  module Model
    def self.included(model_class)
      return if model_class.respond_to?(:can_replicate)
    end

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
