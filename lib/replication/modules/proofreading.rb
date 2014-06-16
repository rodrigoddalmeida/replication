module Replication
  module Modules
    module Proofreading

      def self.extended(model_class)
        model_class.class_eval do
          include Model
        end
      end

      module Model

        def unwound(**options)
          super if valid?
        end

        def replicate(**options)
          if valid?
            super
          else
            raise Replication::UnwoundError, 'The origin must be valid!'
          end
        end
      end
    end
  end
end
