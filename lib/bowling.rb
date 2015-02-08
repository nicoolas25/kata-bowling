class Line
  def initialize(line_str)
    @frames = parse_frames(line_str.dup)
  end

  def score
    @frames.reduce(0) { |sum, frame| sum + frame.score }
  end

  def next_to(frame)
    frame_index = @frames.index(frame)
    @frames[frame_index + 1]
  end

  private

  def parse_frames(line_str)
    frames = line_str.scan(/X/)
    frames = frames[0..8] + [frames[9..-1].join] if frames.size > 10
    frames.map { |frame_str| Frame.new(self, frame_str) }
  end
end

class Frame
  attr_reader :rolls

  def initialize(line, frame_str)
    @line = line
    @rolls = frame_str.split('').map { |roll_str| Roll.new(self, roll_str) }
  end

  def score
    if @rolls.first.strike?
      @rolls.first.score
    end
  end

  def next_to(roll)
    roll_index = @rolls.index(roll)
    if next_roll = @rolls[roll_index + 1]
      next_roll
    else
      next_frame = @line.next_to(self)
      next_frame.rolls.first if next_frame
    end
  end
end

class Roll
  def initialize(frame, roll_str)
    @frame = frame
    @str = roll_str
  end

  def score
    if strike?
      value + next_value(count: 2)
    end
  end

  def value
    if strike?
      10
    end
  end

  def next_value(count: 1)
    return 0 if count == 0
    next_roll = @frame.next_to(self)
    return 0 if next_roll.nil?
    next_roll.value + next_roll.next_value(count: count - 1)
  end

  def strike?
    @str.start_with? 'X'
  end
end
