#!/usr/bin/ruby

def valid(solution)
  return false until solution.length == 8
  return false until solution.all? { |r, c| r >= 1 && r <= 8 && c >= 1 && c <= 8}
  rows_covered = solution.map { |r, c| r }.uniq
  cols_covered = solution.map { |r, c| c }.uniq
  diags_covered = solution.map { |r, c| r + c}.uniq
  diags2_covered = solution.map { |r, c| r - c}.uniq
  return [rows_covered, cols_covered, diags_covered, diags2_covered].all? { |x| x.size == 8 }
end

solutions = (1..8).to_a.permutation.select do |p|
  solution = (1..8).to_a.zip(p)
  valid(solution)
end
p solutions.size
p solutions[0]
