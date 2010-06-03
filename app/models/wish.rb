class Wish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :content, :type => String
  field :permalink, :type => String

  belongs_to_related :user
  belongs_to_related :issue
  has_many_related :votes
  
  before_save :set_permalink

  def voted_by?(user)
    Vote.find(:all, :conditions => {:user_id => user.id, :wish_id => self.id}).count > 0
  end

  def set_permalink
    self.permalink = name.force_encoding("UTF-8").to_permalink
  end

  def to_param
    permalink
  end

end
