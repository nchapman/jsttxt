require 'rdiscount'

class Note < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  
  validates_presence_of :title, :body
  
  define_index do
    indexes :title
    indexes :body
  end
  
  def body=(input)
    self[:body] = input
    self[:body_html] = markdown(input)
  end
  
  def markdown(input)
    # Markdown + Github Flavored Markdown
    RDiscount.new(GFM.parse(input), :smart, :filter_html).to_html
  end
end
