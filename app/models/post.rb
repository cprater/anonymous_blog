class Post < ActiveRecord::Base
  # Remember to create a migration!
  has_and_belongs_to_many :tags

  validates_uniqueness_of :title
  validates_presence_of :title, :content
  before_save :clean_title


  def clean_title
  	self.title.gsub!(/\s+\z/, "")
  end
end
