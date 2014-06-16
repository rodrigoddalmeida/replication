class ReplicationMigration < ActiveRecord::Migration
  def self.up
    create_table :strands do |t|
      t.string :name
      t.text :pairs
      t.references :origin, polymorphic: true, index: true

      t.timestamps
    end
  end

  def self.down
    drop_table :strands
  end
end
