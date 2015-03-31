require "replication/version"

module Replication

  autoload :Process, 'replication/process'
  autoload :Config, 'replication/config'
  autoload :StrandMethods, 'replication/strand_methods'

  module ActiveRecord
    autoload :Strand, 'replication/active_record/strand'
    autoload :PolymorphicStrand, 'replication/active_record/polymorphic_strand'
  end

  module Modules
    autoload :SemiConservative, 'replication/modules/semi_conservative'
    autoload :Proofreading, 'replication/modules/proofreading'

    autoload :Association, 'replication/modules/association'
    autoload :Polymorphic, 'replication/modules/polymorphic'
  end

  def self.defaults
    defaults = {
      only: [],
      except: []
    }
    defaults.merge!({
      strand_class: ::Replication::ActiveRecord::PolymorphicStrand,
      except: [:id, :created_at, :updated_at]
    }) if defined?(ActiveRecord)

    defaults
  end

  def self.extended(model_class)
    return if model_class.respond_to?(:can_replicate)
    model_class.class_eval do
      extend Process
      @replication_config = Class.new(Config).new(self)
      include Model
    end
  end

  # Include or extend it. We work with both.
  def self.included(model_class)
    model_class.extend self
  end

  class UnwoundError < StandardError; end;
end

require 'replication/engine' if defined?(Rails)
