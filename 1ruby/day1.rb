#!/usr/bin/ruby

num = rand(10)+1
begin
  puts "Guess a number from 1 to 10"
end until gets.to_i == num
