class Wish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :content, :type => String

  belongs_to_related :user

end
