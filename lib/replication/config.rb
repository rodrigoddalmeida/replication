module Replication

  class Config

    attr_accessor :model_class, :pairs_method, :strand_class, :except, :only, :options

    def initialize(model_class)
      @model_class = model_class
      @options = {}
    end

    def with(modules)
      modules.each do |m|
        case m
        when Symbol
          model_class.send :include, Replication::Modules.const_get(m.to_s.classify)
        when Hash
          @options.merge!(m)
          with(m.keys)
        # else
          # type not known, ignore
        end
      end
    end

    def set(params)
      params and params.each {|name, value| self.send "#{name}=", value}
    end
  end
end
