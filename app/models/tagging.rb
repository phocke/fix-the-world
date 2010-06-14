class Tagging
  include Mongoid::Document

  belongs_to_related :tag
  belongs_to_related :wish

end
