#!/usr/bin/ruby
require 'lib/polynomialFormatter.rb'

p Polynomial.new([-3,-4,1,0,6]) # => -3x^4-4x^3+x^2+6
p Polynomial.new([1,0,2]) # => -x^2+2
p Polynomial.new([5,-1,0]) # => 5x^2-x
p Polynomial.new([0,1,-2]) # => x - 2
p Polynomial.new([0,0,-2]) # => x - 2

