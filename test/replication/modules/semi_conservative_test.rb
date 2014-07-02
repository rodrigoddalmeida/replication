require "test_helper"

class Replication::Modules::SemiConservativeTest < ActiveSupport::TestCase

  def setup
    Organism.extend Replication::Process
  end

  def organism_object
    Organism.new(name: 'Bacteria', number_of_legs: 1, birth_date: Time.now)
  end

  test "unwound with default options" do
    Organism.can_replicate
    organism = organism_object
    strand = organism.unwound(name: 'First bacteria')

    assert_equal organism.strand_attributes, strand.pairs
  end

  test "replicate with default options" do
    Organism.can_replicate
    organism = organism_object
    strand = organism.replicate(name: 'First bacteria')

    assert_equal organism.strand_attributes, strand.pairs
  end

  test "unwound with whitelist" do
    Organism.can_replicate only: [:name]
    organism = organism_object
    strand = organism.replicate(name: 'First bacteria')

    assert_equal ({ name: 'Bacteria' }), strand.pairs
  end

  test "unwound with blacklist" do
    Organism.can_replicate except: [:id, :number_of_legs, :birth_date, :created_at, :updated_at]
    organism = organism_object
    strand = organism.replicate(name: 'First bacteria')

    assert_equal ({ name: 'Bacteria' }), strand.pairs
  end

end
