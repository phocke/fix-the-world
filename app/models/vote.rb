class Vote
  include Mongoid::Document

  belongs_to_related :user
  belongs_to_related :wish

  validates_uniqueness_of :wish_id, :scope => :user_id
  #validate :user_can_vote

  #def user_can_vote
    #self.wish.voted_by?(self.user)
    ##Vote.find(:first, :conditions=>{:user_id=>self.user_id, :wish_id=>self.wish_id}) == nil
  #end

end
