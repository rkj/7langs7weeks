#!/usr/bin/ruby

def valid(solution)
  rows = solution.map { |r, c| r }
  cols = solution.map { |r, c| c }
  diags = solution.map { |r, c| r + c}
  diags2 = solution.map { |r, c| r - c}
  return [rows, cols, diags, diags2].all? { |x| x.uniq.size == 8 }
end

solutions = (1..8).to_a.permutation.select do |p|
  solution = (1..8).to_a.zip(p)
  valid(solution)
end
p solutions.size
p solutions[0]
