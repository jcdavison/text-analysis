# BEGIN V[0.1]

def item_counts(items)
  counts = {}
  items.split(" ").each do |item|
    if counts.has_key? item
      counts[item] += 1
    else
      counts[item] = 1
    end
  end
  counts
end

def sensible_print(count_statistics)
  puts "---"
  puts "the counts for\n"
  puts "are..."
  count_statistics.each do |key, value|
    key = "nil" if key.nil?
    puts "#{key}, #{value}" 
  end
  puts "end transmission"
  puts "---"
end

# END V[0.1]

# BEGIN v[0.2]

def to_chars(string)
  string.split("")
end

# END V[0.2]

# BEGIN v[0.3]

def sanitize(string)
  string.downcase
end

# END V[0.3]


# BEING V[0.4]

def process_hard_coded_data() 
  data = File.read("./sample_data/moby-dick.txt")
  data.split(" ").map! do |element|
    sanitize(element)
  end
  sensible_print(item_counts(data))
end

# END V[0.4]

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
  return "please enter a file name" unless file_name
  lines = File.open(file_name, "r").each_with_object([]) do |line, object|
    object.push line
  end
  process_multiple_items(lines)
end


def print_histogram(frequencies, char= nil, width = nil)
  width ||= 100; char ||= "*"
  frequencies.each do |key, value|
    print "rel % = #{value} | #{char * (value * width)}\n"
  end
end



def relative_frequencies(counts)
  return unless counts.respond_to?(:keys) && counts.values.all? {|n| n.respond_to? :+}
  total_characters = counts.values.reduce(:+).to_f
  relative_frequencies = counts.each_with_object({}) do |(key, value), object|
    object[key] = (value / total_characters).round(3)
  end
end

puts "WeLcOmE to Text.ly 2.0"
if __FILE__ == $0
  p item_counts([1,2,1,2,1]) == {1 => 3, 2 => 2}
  p item_counts(["a","b","a","b","A","ZZZ"]) == {"a" => 3, "b" => 2, "zzz" => 1}
  p item_counts([]) == nil
  p item_counts(["hi", "hi", "hi"]) == {"hi" => 3}
  p item_counts([true, nil, "dinosaur"]) == {true => 1, nil => 1, "dinosaur" => 1}
  p item_counts(["a","a","A","A"]) != {"a" => 2, "A" => 2}
  p sanitize("@jCDAvison") == "@jcdavison"
  sensible_print item_counts(["a","a","A","A", nil, true, false, true])
  p arrayify_characters("j\$jd") == [ "j", "\$", "j", "d"]
  sensible_print item_counts(arrayify_characters("joooohndaaaahvison"))
  p relative_frequencies({a: 3, b: 5, c: 1000}) == {:a=>0.003, :b=>0.005, :c=>0.992}
  p print_histogram(relative_frequencies({a: 3, b: 5, c: 10}),"8" , 25)
  sensible_print(process_from_file(ARGV[0]))
end
