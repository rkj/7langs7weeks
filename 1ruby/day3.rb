#!/usr/bin/ruby

# Modify the CSV application to support an each method to return a CsvRow
# object. Use method_missing on that CsvRow to return the value for the column
# for a given heading.
# For example, for the file:
# one, two
# lions, tigers
# allow an API that works like this:
# csv = RubyCsv.new
# csv.each {|row| puts row.one}
# This should print "lions".

require '../code/ruby/acts_as_csv.rb'

class CsvRow
  def initialize(headers, rows)
    @rows = rows
    @hash = Hash[*headers.zip(rows).flatten]
    @hash.each do |header, row|
      (class << self; self; end).instance_eval do
        define_method(header + "2") { row }
      end
    end
  end


  def [](idx)
    @rows[idx]
  end

  def method_missing(meth, *args, &block)
    key = meth.to_s
    return @hash[key] if @hash.has_key? key
    super
  end
end


class RubyCsv < ActsAsCsv
  include Enumerable
  acts_as_csv

  def each
    csv_contents.each do |row|
      yield CsvRow.new(headers, row)
    end
  end
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect

key = "first"
key = ARGV[0] if ARGV.size > 0
m.each_with_index do |row, idx|
  puts "#{idx.to_s.rjust(5)} #{row.send key}"
end

puts "-" * 80
m.each_with_index do |row, idx|
  puts "#{idx.to_s.rjust(5)} #{row.send(key + "2")}"
end

puts "-" * 80
m.each_with_index do |row, idx|
  puts "#{idx.to_s.rjust(5)} #{row[1]}"
end

p CsvRow.new(%w(x y z), [1, 2, 3]).methods.sort
