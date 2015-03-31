require "test_helper"

class Replication::ProcessTest < ActiveSupport::TestCase

  def setup
    Organism.extend Replication
  end

  test "extending provide can_replicate method" do
    assert_equal true, Organism.respond_to?(:can_replicate)
  end

  test "extending provide new_from_strand method" do
    assert_equal true, Organism.respond_to?(:new_from_strand)
  end

  test "can_replicate with default options" do
    Organism.can_replicate

    assert_equal true, Organism.new.respond_to?(:unwound) # provided by default module
  end

  test "can_replicate with other attributes method" do
    Organism.can_replicate :attributes_alias

    assert_equal :attributes_alias, Organism.new.replication_config.pairs_method
  end

  test "can_replicate with other strand class" do
    WeirdStrandClass = Struct.new(:name, :pairs, :origin)
    Organism.can_replicate strand_class: WeirdStrandClass

    assert_equal WeirdStrandClass, Organism.new.strand_class
  end

  test "new_from_strand with id" do
    Organism.can_replicate
    original = Organism.create(name: 'Bacteria', number_of_legs: 3, birth_date: Time.now)
    strand = original.replicate(name: 'Original Bacteria')

    assert_instance_of Organism, Organism.new_from_strand(strand.id)
  end

  test "new_from_strand with name" do
    Organism.can_replicate
    original = Organism.create(name: 'Bacteria', number_of_legs: 3, birth_date: Time.now)
    strand = original.replicate(name: 'Original Bacteria')

    assert_instance_of Organism, Organism.new_from_strand(name: 'Original Bacteria')
  end

  test "STI support" do
    Animal.can_replicate
    original = Animal.create(name: 'Bat', number_of_legs: 2, birth_date: Time.now)
    strand = original.replicate(name: 'Original Bat')

    assert_equal "Animal", strand.origin_type
  end
end
