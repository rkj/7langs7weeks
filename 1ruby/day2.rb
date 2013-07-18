#!/usr/bin/ruby

# Print the contents of an array of sixteen numbers, four numbers at a
# time, using just each. Now, do the same with each_slice in Enumerable.

a = 16.times.map { rand() }
tmp = []
a.each do |e|
  tmp << e
  if tmp.size == 4
    p tmp
    tmp = []
  end
end

# The Tree class was interesting, but it did not allow you to specify a new
# tree with a clean user interface. Let the initializer accept a nested
# structure of hashes. You should be able to specify a tree like this:
# {'grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {},
# 'child 4' => {} } } }.



# Write a simple grep that will print the lines of a file having any occur-
# rences of a phrase anywhere in that line. You will need to do a simple
# regular expression match and read lines from a file. (This is surprisingly
# simple in Ruby.) If you want, include line numbers.

def grep(file, pattern, line_no = false)
  pattern = Regexp.new(pattern) if pattern.is_a? String
  File.open(file).each_with_index do |line, idx|
    next unless line =~ pattern
    printf((line_no ? "%5d " : "") + line, idx)
  end
end

grep(ARGV[0], ARGV[1]) if ARGV.size >= 2
puts "-------"
grep(ARGV[0], ARGV[1], true) if ARGV.size >= 2

