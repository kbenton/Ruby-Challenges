#!/usr/bin/ruby
require 'lib/polynomial.rb'

puts Polynomial.new([-3,-4,1,0,6]).to_s   # => -3x^4-4x^3+x^2+6
puts Polynomial.new([1,0,2]).to_s         # => -x^2+2
puts Polynomial.new([5,-1,0]).to_s        # => 5x^2-x
puts Polynomial.new([0,1,-2]).to_s        # => x-2
puts Polynomial.new([-1,2,3,-5]).to_s     # => -x^3+2x^2+3x-5
puts Polynomial.new([0,0,-2]).to_s        # => exception

