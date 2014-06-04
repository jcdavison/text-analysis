# This is the base code for v0.1 of our Ruby text analyzer.
# Visit https://github.com/codeunion/text-analysis/wiki to see what to do.
#
# Send an email to your cohort mailing list if you have any questions
# or you're stuck!  These comments are here to help you, but please delete them
# as you go along. You wouldn't normally have such heavily-commented code.

# Method name: item_counts
# Input:   An arbitrary array
#
# Returns: A hash where every item is a key whose value is the number of times
#          that item appears in the array
#
# Prints:  Nothing

# Here are some examples:
#     item_counts(["I", "am", "Sam", "I", "am"])
#       # => {"I" => 2, "am" => 2, "Sam" => 1}
#
#     item_counts([10, 20, 10, 20, 20])
#       # => {10 => 2, 20 => 3}
#
# In short, item_counts(array) tells us how many times each item appears
# in the input array.

require 'pry'
def item_counts(array)
  counts = {} # Initialize counts to an empty Hash

  array.each do |item|
    item = item
    if counts.has_key? item
      counts[item] += 1
    else
      counts[item] = 1
    end
  end

  counts # This returns the "counts" hash
end

def sensible_print(count_statistics)
  puts "---"
  puts "the counts for\n"
  p count_statistics
  puts "are..."
  count_statistics.each do |key, value|
    key = "nil" if key.nil?
    puts "#{key}, #{value}" 
  end
  puts "end transmission"
  puts "---"
end

def arrayify_characters(valid_string)
  valid_string.split("")
end


# p item_counts([1,2,1,2,1]) == {1 => 3, 2 => 2}
# p item_counts(["a","b","a","b","a","ZZZ"]) == {"a" => 3, "b" => 2, "ZZZ" => 1}
# p item_counts([]) == {}
# p item_counts(["hi", "hi", "hi"]) == {"hi" => 3}
# p item_counts([true, nil, "dinosaur"]) == {true => 1, nil => 1, "dinosaur" => 1}
# p item_counts(["a","a","A","A"]) == {"a" => 2, "A" => 2}
sensible_print item_counts(["a","a","A","A", nil, true, false, true])
p arrayify_characters("johndavison!@#\$")
sensible_print item_counts(arrayify_characters("joooohndaaaahvison"))
