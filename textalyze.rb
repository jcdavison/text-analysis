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

def item_counts(items, words = nil)
  words = false
  return if items.any? { |item| contains_words?(item) && words == false}

  counts = {}

  items.each do |item|
    # i'm not really sure if respond_to? is the correct defensive pattern.
    item = sanitize(item)
    if counts.has_key? item
      counts[item] += 1
    else
      counts[item] = 1
    end
  end
  counts
end

def contains_words?(phrase)
  return false unless phrase.match(/([a-zA-Z])*\s+([a-zA-Z])+/)
  true
end

def process_multiple_items(items)
  results = {}
  items.each do |item|
    count_statistics = item_counts(arrayify_characters(item))
    if results.empty?
      results = count_statistics
    else
      results.merge!(count_statistics) do | key, oldvalue, newvalue |
        oldvalue + newvalue
      end
    end
  end
  results
end

def process_from_file(file_name)
  lines = File.open(file_name, "r").each_with_object([]) do |line, object|
    object.push line
  end
  process_multiple_items(lines)
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

def sanitize(characters)
  return unless characters.respond_to? :downcase
  characters.downcase
end

puts "WeLcOmE to Text.ly 2.0"
sensible_print(process_from_file(ARGV[0]))
# p item_counts([1,2,1,2,1]) == {1 => 3, 2 => 2}
# p item_counts(["a","b","a","b","A","ZZZ"]) == {"a" => 3, "b" => 2, "zzz" => 1}
# p item_counts([]) == {}
# p item_counts(["hi", "hi", "hi"]) == {"hi" => 3}
# p item_counts([true, nil, "dinosaur"]) == {true => 1, nil => 1, "dinosaur" => 1}
# p item_counts(["a","a","A","A"]) == {"a" => 2, "A" => 2}
# p sanitize("@jCDAvison") == "@jcdavison"
# sensible_print item_counts(["a","a","A","A", nil, true, false, true])
# p arrayify_characters("johndavison!@#\$")
# sensible_print item_counts(arrayify_characters("joooohndaaaahvison"))
