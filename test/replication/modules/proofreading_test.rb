require "test_helper"

class Replication::Modules::ProofreadingTest < ActiveSupport::TestCase

  def setup
    Organism.can_replicate with: :proofreading
  end

  test "unwound with proofreading" do
    organism = organism_object
    organism.name = nil
    strand = organism.unwound(name: 'First bacteria')

    assert_nil strand
  end

  test "replicate with proofreading" do
    organism = organism_object
    organism.name = nil

    assert_raises(Replication::UnwoundError) { organism.replicate(name: 'First bacteria') }
  end
end
