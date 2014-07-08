class ToolMigration < ActiveRecord::Migration
  def self.up
    create_table :toolings do |t|
      t.references :organism
      t.references :tool
    end

    create_table :tools do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :toolings
    drop_table :tools
  end
end
