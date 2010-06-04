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
  # has_many_related :tags, :through => :taggings IS WORKING
  
  before_save :set_permalink

  def voted_by?(user)
    Vote.find(:all, :conditions => {:user_id => user.id, :wish_id => self.id}).count > 0
  end

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
    self.taggings.collect(&:tag).collect(&:name)
  end

  # methods for forms
  def tag_list
    self.tags.uniq * ", "
  end

  def tag_list=(tags)
    self.taggings.destroy_all

    tags = tags.split(", ") if tags.is_a? String
    tags.each do |tag|
      self.add_tag(tag)  
    end
  end

end
