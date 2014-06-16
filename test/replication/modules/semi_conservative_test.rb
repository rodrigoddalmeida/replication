require "test_helper"

class Replication::Modules::SemiConservativeTest < ActiveSupport::TestCase

  def setup
    Organism.extend Replication::Process
  end

  test "unwound with default options" do
    Organism.can_replicate
    organism = Organism.new(name: 'Bacteria', number_of_legs: 1, birth_date: Time.now)
    strand = organism.unwound(name: 'First bacteria')

    assert_equal organism.strand_attributes, strand.pairs
  end

  test "replicate with default options" do
    Organism.can_replicate
    organism = Organism.new(name: 'Bacteria', number_of_legs: 1, birth_date: Time.now)
    strand = organism.replicate(name: 'First bacteria')

    assert_equal organism.strand_attributes, strand.pairs
  end
end
