class String
  def to_camel_case
    self.downcase.gsub(/[_ ][a-zA-Z]/) { |m| m[1].upcase }
  end
end
