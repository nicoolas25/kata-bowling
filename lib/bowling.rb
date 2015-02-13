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
    elsif @rolls[-2].spare?
      @rolls[0..-2]
    else
      @rolls
    end
  end

  def next_to(roll)
    index = @rolls.index(roll)
    @rolls[index + 1]
  end

  def prev_to(roll)
    index = @rolls.index(roll)
    @rolls[index - 1] if index > 0
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
    elsif spare?
      value + next_value(count: 1)
    else
      value
    end
  end

  def strike?
    @str == 'X'
  end

  def spare?
    @str == '/'
  end

  def value
    if strike?
      10
    elsif spare?
      10 - prev_value
    else
      @str.to_i
    end
  end

  def next_value(count: 1)
    return 0 if count == 0 || next_roll.nil?
    next_roll.value + next_roll.next_value(count: count - 1)
  end

  def prev_value
    prev_roll.nil? ? 0 : prev_roll.value
  end

  def next_roll
    @next_roll ||= @line.next_to(self)
  end

  def prev_roll
    @prev_roll ||= @line.prev_to(self)
  end
end
