class Wish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :content, :type => String

  belongs_to_related :user
  has_many_related :votes
  has_many_related :taggings

  def voted_by?(user)
    Vote.find(:first, :conditions => {:user_id => user.id, :wish_id => self.id}).nil?
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def tags
    self.taggings.collect(&:tag)
  end
  
  #we tried to mimic ActiveRecord intereface bu we were not able to use original fullstop so we invited our own one :D
  def tags•build(name)
    tag = Tag.find_or_create_by(:name => name)
    self.taggings.build(:tag => tag).save
  end
end
