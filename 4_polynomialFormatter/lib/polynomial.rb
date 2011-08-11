class Polynomial
  attr_reader :order
  attr_reader :to_s
  attr_reader :coefficients

  def initialize(coefficients)
    while not coefficients.empty? do
      c = coefficients.shift
      if c != 0
        coefficients.unshift(c)
        break
      end
    end

    raise ArgumentError, "Need at least 2 coefficients." unless (coefficients.size > 1)

    @coefficients = coefficients

    @to_s = ""
    @order = 0

    while not coefficients.empty? do
      c = coefficients.pop
      op = c < 0 ? "-" : "+"

      case order
      when 0
        @to_s.insert(0,"")
      when 1
        if c != 0
          @to_s.insert(0,"x")
        end
      else
        if c != 0
          @to_s.insert(0,"x^#{order}")
        end
      end

      case c.abs
      when 0
      when 1
        if order == 0
          @to_s.insert(0,"1")
        end
      else
        @to_s.insert(0,c.abs.to_s)
      end

      unless c == 0
        @to_s.insert(0,op)
      end

      @order+=1
    end
    if @to_s[0].chr == "+"
      @to_s.slice!(0)
    end
  end
end
