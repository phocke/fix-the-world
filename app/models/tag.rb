class Tag
  include Mongoid::Document

  field :name, :type => String

  # returns array of tags and counts: 
  #   [["matt", 3], ["bob", 2], ["bill", 1], ["joe", 1], ["frank", 1]]
  def self.tag_list_with_count
    # TODO
  end
end
