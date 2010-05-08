class Vote
  include Mongoid::Document

  belongs_to_related :user
  belongs_to_related :wish

  validates_uniqueness_of :user_id, :scope => :wish_id

end
