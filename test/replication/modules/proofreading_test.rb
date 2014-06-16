require "test_helper"

class Replication::Modules::ProofreadingTest < ActiveSupport::TestCase

  def setup
    Organism.extend Replication::Process
    Organism.can_replicate with: :proofreading
  end

  test "unwound with proofreading" do
    organism = Organism.new(number_of_legs: 1, birth_date: Time.now) # invalid (needs name)
    strand = organism.unwound(name: 'First bacteria')

    assert_nil strand
  end

  test "replicate with proofreading" do
    organism = Organism.new(number_of_legs: 1, birth_date: Time.now) # invalid (needs name)

    assert_raises(Replication::UnwoundError) { organism.replicate(name: 'First bacteria') }
  end
end
