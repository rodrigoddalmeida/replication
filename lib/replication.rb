require "replication/version"

module Replication

  autoload :Process, 'replication/process'
  autoload :Config, 'replication/config'
  autoload :StrandMethods, 'replication/strand_methods'

  module ActiveRecord
    autoload :Strand, 'replication/active_record/strand'
  end

  module Modules
    autoload :SemiConservative, 'replication/modules/semi_conservative'
    autoload :Proofreading, 'replication/modules/proofreading'
  end

  def self.defaults
    defaults = {
      only: [], 
      except: []
    }
    defaults.merge!({
      strand_class: ::Replication::ActiveRecord::Strand,
      except: [:id, :created_at, :updated_at]
    }) if defined?(ActiveRecord)
  end

  class UnwoundError < StandardError; end;
end

require 'replication/engine' if defined?(Rails)
