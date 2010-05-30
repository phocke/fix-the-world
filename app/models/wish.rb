class Wish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :content, :type => String

  belongs_to_related :user
  belongs_to_related :issue
  has_many_related :votes

  def voted_by?(user)
    Vote.find(:all, :conditions => {:user_id => user.id, :wish_id => self.id}).count > 0
  end

end
