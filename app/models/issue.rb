class Issue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to_related :user
  has_many_related :wishes

  field :name, :type => String
  field :description, :type => String
  field :permalink, :type => String

  validates_uniqueness_of :name
  before_save :set_permalink, :add_host_entry
  named_scope :latest, limit(5).order_by([:created_at, :desc])

  def set_permalink
    #self.permalink = name.force_encoding("UTF-8").to_permalink
    self.permalink = name.to_permalink
  end

  def to_param
    permalink
  end

  def add_host_entry
    #File.prepend('/etc/hosts', "127.0.0.1  #{self.permalink}.#{$HOST_NAME}\n")
  end
end
