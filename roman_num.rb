arr = [1,2,3,4,5,6,7,8,9,10]

class Fixnum
ROMAN_NUMBERS = {
  1 => "I",
  2 => "II",
  3 => "III",
  4 => "IV",
  5 => "V",
  6 => "VI",
  7 => "VII",
  8 => "VIII",
  9 => "IX",
  10 => "X",
}
=begin
ROMAN_NUM = Array.new(10) do |index|
       target = index + 1
       ROMAN_NUMBERS.keys.sort { |a, b| b <=> a }.inject("") do |roman, div|
           times, target = target.divmod(div)
           roman << ROMAN_NUMBERS[div] * times
       end
   end
end
=end
def roman
  return '' if self == 0
  ROMAN_NUMBERS.map do |value, letter|
    if self == 1
      puts "I"
    elsif self == 2
      puts "II"
    elsif self == 3
      puts "III"
    elsif self == 4
      puts  "IV"
    elsif self == 5
      puts "V"
    elsif self == 6
      puts "VI"
    elsif self == 7
      puts "VII"
    elsif self == 8
      puts "VIII"
    elsif self == 9
      puts "IX"
    else self == 10
      puts "X"
      return  ( letter * (self / value)) << (self % value).roman if value <= self
    end
    return (self % value).roman
  end
end
end
arr.map(&:roman)
1.roman
4.roman
8.roman
9.roman
#now refactor
