class AddCachedTagListToNote < ActiveRecord::Migration
  def self.up
    add_column :notes, :cached_tag_list, :string
  end

  def self.down
    remove_column :notes, :cached_tag_list
  end
end
