#!/usr/bin/ruby

require 'bowling'

describe Bowling, "#score" do
  it "returns 0 for all gutter game" do
    bowling = Bowling.new
    20.times { bowling.roll(0) }
    bowling.score.should eq(0)
  end
end

