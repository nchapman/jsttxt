require 'rdiscount'

class Note < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  
  validates_presence_of :title, :body
  
  define_index do
    indexes :title
    indexes :body
    indexes :cached_tag_list
  end
  
  def body_html=(input)
    self[:body_html] = input
    self[:body] = input.gsub(/<\/?[^>]+>/, "")
  end
  
  def markdown(input)
    # Markdown + Github Flavored Markdown
    RDiscount.new(GFM.parse(input), :smart, :filter_html).to_html
  end
end
