require "test_helper"

class Replication::Modules::AssociationTest < ActiveSupport::TestCase

  test "replicates associations" do
    Organism.can_replicate with: { associations: [:toolings, reject_if: :all_blank] }
    
    organism = organism_object
    organism.tools.build(name: 'wrench')
    organism.save
    strand = organism.unwound(name: 'Monkey with a wrench')

    Tooling.create(tool: Tool.first) # create unassociated tooling

    assert_includes strand.pairs, :toolings_attributes
    assert_equal 1, strand.pairs[:toolings_attributes].length
    assert_equal 2, Tooling.count
  end
end

