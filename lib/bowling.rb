class Line
  def initialize(str)
    @str = str
    @rolls = @str.chars.each_with_object([]) do |char, rolls|
      rolls << (char == 'X' ? 10 : char == '/' ? 10 - rolls[-1] : char.to_i)
    end
  end

  def score
    @cursor = @total = 0
    10.times { read_frame }
    @total
  end

  private

  def read_frame
    read_strike || read_couple
  end

  def read_strike
    if @str[@cursor] == 'X'
      @total += @rolls[@cursor] + @rolls[@cursor + 1] + @rolls[@cursor + 2]
      @cursor += 1
    end
  end

  def read_couple
    @total += @rolls[@cursor] + @rolls[@cursor + 1]
    @total += @rolls[@cursor + 2] if @str[@cursor + 1] == '/'
    @cursor += 2
  end
end
