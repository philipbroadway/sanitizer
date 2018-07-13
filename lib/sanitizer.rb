require "sanitizer/version"

class String

  def self.mask(source = "", trailing_characters_to_reveal = 4)
    total_length = source.length || 0
    return "" unless total_length > 0
    return (["*"] * total_length).join unless total_length > trailing_characters_to_reveal
    (["*"] * (total_length - trailing_characters_to_reveal)).join + source[total_length - trailing_characters_to_reveal..total_length]
  end

  def mask(trailing_characters_to_reveal = 4)
    String.mask(self, trailing_characters_to_reveal)
  end

end

class Hash

  def self.sanitize(source = {}, mask = [:password], trailing_characters_to_reveal = 4)
    source.each do |key, value|
      if source[key].is_a?(Hash)
        Hash.sanitize(source[key], mask, trailing_characters_to_reveal)
      elsif mask.include?(key)
        source[key] = "#{source[key]}".mask(trailing_characters_to_reveal)
      end
    end
    source
  end

  def sanitize(mask = [:password], trailing_characters_to_reveal = 4)
    Hash.sanitize(self, mask, trailing_characters_to_reveal)
  end

end