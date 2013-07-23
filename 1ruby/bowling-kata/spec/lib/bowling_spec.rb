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

  it "returns 16 for game with a spare" do
    bowling = Bowling.new
    bowling.roll(5);
    bowling.roll(5); # spare
    bowling.roll(1);
    17.times { bowling.roll(0) }
    bowling.score.should eq(5 + 5 + 1 + 1)
  end

  it "returns 12 for game with a spare" do
    bowling = Bowling.new
    bowling.roll(10); # strike
    bowling.roll(1);
    bowling.roll(1);
    17.times { bowling.roll(0) }
    bowling.score.should eq(10 + 1 + 1 + 1 + 1)
  end
end

