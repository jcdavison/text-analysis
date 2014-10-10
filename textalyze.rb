# BEGIN V[0.1]

def item_counts(items)
  counts = {}
  items.each do |item|
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


# BEGIN V[0.4]

def process_hard_coded_data() 
  data = File.read("./sample_data/moby-dick.txt")
  data.split(" ").map! do |element|
    sanitize(element)
  end
  sensible_print(item_counts(data))
end

# END V[0.4]


# BEGIN V[1.0]

def request_user_supplied_file_name()
  available_files = "great-gatsby.txt moby-dick.txt tale-of-two-cities.txt" 
  puts "Please enter a file to process."
  puts available_files
  gets.chomp
end

def process_user_designated_file(file_name)
  data = File.read("./sample_data/#{file_name}")
  data.split(" ").map! do |element|
    sanitize(element)
  end
end

def request_process_display_user_supplied_file()
  user_specified_file = request_user_supplied_file_name()
  counts = item_counts(process_user_designated_file(user_specified_file))
  sensible_print(counts)
end

# END V[1.0]


# BEGIN V[1.1]

def basic_frequency_count(items)
  # notice that item_counts() was built in V[0.1]
  counts = item_counts(items)
  sum_of_all_counts = counts.values.reduce(:+)
  counts.each do |key,value|
    counts[key] = (value.to_f / sum_of_all_counts).round(2)
  end
end

# END V[1.1]


# BEGIN V[1.2]

def print_histogram(frequencies)
  width = frequencies.max.pop
  frequencies.each do |key, value|
    print "rel % = #{value} | #{"*" * (value * width)}\n"
  end
end

# END V[1.2]

puts "WeLcOmE to Text.ly 2.0"
if __FILE__ == $0
  # What kind of 'rumble strips' make sense? 
end
