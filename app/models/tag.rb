class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_and_belongs_to_many :posts
  validates_uniqueness_of :title
end
