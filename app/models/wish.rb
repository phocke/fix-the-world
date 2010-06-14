class Wish
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :content, :type => String
  field :permalink, :type => String

  belongs_to_related :user
  belongs_to_related :issue
  has_many_related :votes
  has_many_related :taggings

  has_many_related :taggings
  # has_many_related :tags, :through => :taggings IS WORKING
  
  before_save :set_permalink
  after_save :save_tags

  named_scope :tagged_with, lambda { |tag| criteria.id(Tag.where(:name => tag).first.taggings.collect(&:wish_id)) }

  def voted_by?(user)
    Vote.find(:first, :conditions => {:user_id => user.id, :wish_id => self.id}).nil?
  end

<<<<<<< HEAD
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def tags
    self.taggings.collect(&:tag)
  end
  
  #we tried to mimic ActiveRecord intereface bu we were not able to use original fullstop so we invited our own one :D
  def tags•build(name)
    tag = Tag.find_or_create_by(:name => name)
    self.taggings.build(:tag => tag).save
  end
=======
  def set_permalink
    self.permalink = name.force_encoding("UTF-8").to_permalink
  end

  def to_param
    permalink
  end

  # TODO clean up, move to external module
  
  def add_tag(name)
    tag = Tag.find_or_create_by(:name => name)
    self.taggings.build(:tag => tag).save
  end

  def tags
    self.taggings.collect(&:tag).collect(&:name).sort
  end

  # methods for forms
  def tag_list
    self.tags.uniq * ", "
  end

  def tag_list=(tags)
    @tag_list_temp = tags # tags can be saved only if wish is saved
  end

  def save_tags
    tags = @tag_list_temp
    self.taggings.destroy_all

    (tags = tags.split(", ")) if tags.is_a? String
    tags.each do |tag|
      self.add_tag(tag)  
    end
  end

>>>>>>> 710b3e293e0f1334d3de2ebfb984dbb6d0413ca5
end
