class AddBodyHtmlToNote < ActiveRecord::Migration
  def self.up
    add_column :notes, :body_html, :text
  end

  def self.down
    remove_column :notes, :body_html
  end
end
