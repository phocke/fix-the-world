class Issue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to_related :user
  has_many_related :wishes

  field :name, :type => String
  field :description, :type => String
  field :permalink, :type => String

  before_save :set_permalink

  def set_permalink
    self.permalink = name.force_encoding("UTF-8").to_permalink
  end

  def to_param
    permalink
  end
end
