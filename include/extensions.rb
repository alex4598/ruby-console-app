class String
  
  ACCENTS_MAPPING = {
    'E' => [200,201,202,203],
    'e' => [232,233,234,235],
    'A' => [192,193,194,195,196,197,258],
    'a' => [224,225,226,227,228,229,230,259],
    'C' => [199],
    'c' => [231],
    'O' => [210,211,212,213,214,216],
    'o' => [242,243,244,245,246,248],
    'I' => [204,205,206,207],
    'i' => [236,237,238,239],
    'U' => [217,218,219,220],
    'u' => [249,250,251,252],
    'N' => [209],
    'n' => [241],
    'S' => [350,536],
    's' => [351,537],
    'T' => [354,538],
    't' => [355,539],
    'Y' => [221],
    'y' => [253,255],
    'AE' => [306],
    'ae' => [346],
    'OE' => [188],
    'oe' => [189]
  }

  def no_accents
    str = String.new(self)
    String::ACCENTS_MAPPING.each {|letter,accents|
      accents_packed = accents.pack('U*')
      rxp = Regexp.new("[#{accents_packed}]", nil)
      str.gsub!(rxp, letter)
    }
    str
  end
 
  def numeric?
    Float(self) != nil rescue false
  end

  def numeric
      self.numeric? ? self.gsub(/(?:(\..*[^0])0+|\.0+)$/,'\1') : self #remove trailing zeroes
  end

  def norm
    self.
      strip.
      numeric.
      no_accents.
      gsub(/[^a-zA-Z0-9 _.@-]/,' '). # replace characters not in regexp with spaces
      gsub(/(\s|\u00A0)+/, ' ') # shrink/replace SPACEs and NBSPs to a single SPACE
  end

end