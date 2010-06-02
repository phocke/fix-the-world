class Wish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :content, :type => String

  belongs_to_related :user
  has_many_related :votes

  def voted_by?(user)
    #if there's no vote we'll get nil so it's shorter than before ;)
    Vote.find(:first, :conditions => {:user_id => user.id, :wish_id => self.id})
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

end
