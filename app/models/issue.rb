class Issue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to_related :user
  has_many_related :wishes

  field :name, :type => String
  field :description, :type => String

end
