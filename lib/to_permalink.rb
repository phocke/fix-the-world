# encoding: utf-8

class String

  def to_permalink
    result = self.dup
    result.gsub!(/[ĄÀÂÃ]/,'A')
    result.gsub!(/[âäàãáäå�?ăąǎǟǡǻ�?ȃȧẵặ]/,'a')
    result.gsub!(/[Ę]/,'E')
    result.gsub!(/[ëêéèẽēĕėẻȅȇẹȩęḙḛ�?ếễểḕḗệ�?]/,'e')
    result.gsub!(/[Ì�?ÎĨ]/,'I')
    result.gsub!(/[�?iìíîĩīĭïỉ�?ịįȉȋḭɨḯ]/,'i')
    result.gsub!(/[ÒÓÔÕÖ]/,'O')
    result.gsub!(/[òóôõ�?�?ȯö�?őǒ�?�?ơǫ�?ɵøồốỗổȱȫȭ�?�?ṑṓ�?ớỡởợǭộǿ]/,'o')
    result.gsub!(/[ÙÚÛŨÜ]/,'U')
    result.gsub!(/[ùúûũūŭüủůűǔȕȗưụṳųṷṵṹṻǖǜǘǖǚừứữửự]/,'u')
    result.gsub!(/[ỳýŷỹȳ�?ÿỷẙƴỵ]/,'y')
    result.gsub!(/[œ]/,'oe')
    result.gsub!(/[ÆǼǢæ]/,'ae')
    result.gsub!(/[Ń]/,'N')
    result.gsub!(/[ñǹń]/,'n')
    result.gsub!(/[ÇĆ]/,'C')
    result.gsub!(/[çć]/,'c')
    result.gsub!(/[ß]/,'ss')
    result.gsub!(/[œ]/,'oe')
    result.gsub!(/[ĳ]/,'ij')
    result.gsub!(/[Ł]/,'L')
    result.gsub!(/[�?ł]/,'l')
    result.gsub!(/[Ś]/,'S')
    result.gsub!(/[ś]/,'s')
    result.gsub!(/[ŹŻ]/,'Z')
    result.gsub!(/[źż]/,'z')
    result.gsub!(/[^\x00-\x7F]+/, '') # Remove anything non-ASCII entirely (e.g. diacritics).
    result.gsub!(/[^\w_ \-]+/i,   '') # Remove unwanted chars.
    result.gsub!(/[ \-]+/i,      '-') # No more than one of the separator in a row.
    result.gsub!(/^\-|\-$/i,      '') # Remove leading/trailing separator.
    result.downcase!

    result = Digest::SHA1.hexdigest("#{Time.now.to_s.split(//).sort_by {rand}}") if result.size.zero?

    result
  end

end
