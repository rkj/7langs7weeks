#!/usr/bin/ruby

# http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata

class Frame
  def initialize
    @rolls = []
  end

  def add(pins)
    @rolls << pins
  end

  def finished?
    score == 10 || @rolls.size >= 2
  end

  def score(last = nil)
    last ||= Frame.new
    sum = @rolls.inject(0) { |s, i| s + i }
    sum += @rolls[0] || 0 if last.spare?
    sum += @rolls[1] || 0 if last.strike?
    sum
  end

  def spare?
    @rolls.size > 1 && score == 10
  end

  def strike?
    @rolls.first == 10
  end
end

class Bowling
  def initialize
    @frames = []
  end

  def roll(pins)
    frame = @frames.last
    if frame.nil? || frame.finished?
      frame = Frame.new
      @frames << frame
    end
    frame.add(pins)
  end

  def score
    last = nil
    @frames.inject(0) { |s, i| s += i.score(last); last = i; s }
  end
end
