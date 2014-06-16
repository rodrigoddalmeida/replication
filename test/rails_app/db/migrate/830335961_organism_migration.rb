class OrganismMigration < ActiveRecord::Migration
  def self.up
    create_table :organisms do |t|
      t.string :name
      t.integer :number_of_legs
      t.datetime :birth_date

      t.timestamps
    end
  end

  def self.down
    drop_table :organisms
  end
end
