module Replication

  class Config

    attr_accessor :model_class, :pairs_method, :strand_class, :except, :only

    def initialize(model_class)
      @model_class = model_class
    end

    def with(modules)
      modules.each do |m|
        model_class.send :include, Replication::Modules.const_get(m.to_s.classify)
      end
    end

    def set(options)
      options and options.each {|name, value| self.send "#{name}=", value}
    end
  end
end
