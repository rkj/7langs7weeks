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

  def sum
    @rolls.inject(0) { |s, i| s + i }
  end

  def score(next_frame = nil, next_next = nil)
    tmp = sum()
    tmp += next_frame.first || 0 if next_frame && (spare? || strike?)
    tmp += next_frame.second || next_next.first || 0 if next_frame && strike?
    tmp
  end

  def spare?
    @rolls.size > 1 && sum == 10
  end

  def strike?
    @rolls.first == 10
  end

  def first
    @rolls.first
  end

  def second
    @rolls[1]
  end

  def inspect
    "<Frame #{@rolls.inspect} sum: #{sum} spare: #{spare?} strike: #{strike?}>"
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
    sum = 0
    @frames << Frame.new while @frames.size <= 15
    @frames.each_cons(3) { |frame, n1, n2| sum += frame.score(n1, n2); p sum }
    sum
  end
end
