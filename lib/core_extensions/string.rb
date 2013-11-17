class String

  # Modifies str into a URL-friendly slug
  #
  # @return [String] the slugged str
  def slugify!
    rep = self.strip.downcase
    rep.gsub!(/['`]/, "")
    rep.gsub!(/\s*@\s*/, " at ")
    rep.gsub!(/\s*&\s*/, " and ")
    rep.gsub!(/\s*[^A-Za-z0-9\.\-]\s*/, '-')
    rep.gsub!(/_+/, "-")
    rep.gsub!(/\A[_\.]+|[_\.]+\z/, "")
    self.replace(rep)
  end

  # Returns a copy of str converted into a URL-friendly slug
  #
  # @return [String] the slugged str
  def slugify
    self.dup.slugify!
  end

  # Parses str into an array of words, split on space, underscore, or capitalization
  #
  # @return [Array<String>] The str words
  def words
    words = [self]
    if self =~ / /
      words = self.split(' ')
    elsif self =~ /_/
      words = self.split('_')
    else
      words = self.scan(/[A-Z][a-z]*/)
    end
    words
  end
end
