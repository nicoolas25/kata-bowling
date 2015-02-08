class Line
  def initialize(rolls_str)
    @rolls = rolls_str.split('').map { |roll_str| Roll.new(self, roll_str) }
  end

  def score
    rolls_to_count.reduce(0) { |sum, roll| sum + roll.score }
  end

  def rolls_to_count
    if @rolls[-3].strike?
      @rolls[0..-3]
    end
  end

  def next_to(roll)
    index = @rolls.index(roll)
    @rolls[index + 1]
  end
end

class Roll
  def initialize(line, roll_str)
    @line = line
    @str = roll_str
  end

  def score
    if strike?
      value + next_value(count: 2)
    end
  end

  def strike?
    @str == 'X'
  end

  def value
    if strike?
      10
    end
  end

  def next_value(count: 1)
    return 0 if count == 0 || next_roll.nil?
    next_roll.value + next_roll.next_value(count: count - 1)
  end

  def next_roll
    @next_roll ||= @line.next_to(self)
  end
end
