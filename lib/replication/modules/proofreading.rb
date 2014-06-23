module Replication
  module Modules
    module Proofreading

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
