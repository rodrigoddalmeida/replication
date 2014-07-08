require "test_helper"

class Replication::Modules::AssociationTest < ActiveSupport::TestCase

  test "replicates associations" do
    Organism.can_replicate with: { associations: [:toolings, reject_if: :all_blank] }
    
    organism = organism_object
    organism.tools.build(name: 'wrench')
    organism.save
    strand = organism.unwound(name: 'Monkey with a wrench')

    assert_includes strand.pairs, :toolings_attributes
  end
end

