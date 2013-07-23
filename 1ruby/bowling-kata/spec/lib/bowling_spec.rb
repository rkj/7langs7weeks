#!/usr/bin/ruby

require 'bowling'

describe Bowling, "#score" do
  it "returns 0 for all gutter game" do
    bowling = Bowling.new
    20.times { bowling.roll(0) }
    bowling.score.should eq(0)
  end

  it "returns 20 for all one game" do
    bowling = Bowling.new
    20.times { bowling.roll(1) }
    bowling.score.should eq(20)
  end
end

