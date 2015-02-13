class Line
  def initialize(str)
    @rolls = str.chars.each_with_object([]) do |char, rolls|
      rolls << (char == 'X' ? 10 : char == '/' ? 10 - rolls[-1] : char.to_i)
    end
  end

  def score
    @cursor = 0
    (1..10).map{ read_frame }.reduce(0, &:+)
  end

  private

  def read_frame
    first, second, follower = @rolls[@cursor .. @cursor + 2]
    if first == 10
      @cursor += 1
      first + second + follower
    else
      @cursor += 2
      if first + second == 10
        first + second + follower
      else
        first + second
      end
    end
  end
end
