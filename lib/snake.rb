class Snake
  attr_accessor :x, :y, :direction, :segments, :length, :speed

  def initialize(window)
    @window = window
    @direction = :right
    @length = 4
    @speed = 4
    @segments = []
    @head = Segment.new(@window, self, [320, 263.5])
    @segments.push(@head)
  end

  def turn
    if @direction == :right
      x = @head.x + @speed
      y = @head.y
      @head = Segment.new(@window, self, [x, y])
    elsif @direction == :down
      x = @head.x
      y = @head.y + @speed
      @head = Segment.new(@window, self, [x, y])
    elsif @direction == :left
      x = @head.x - @speed
      y = @head.y
      @head = Segment.new(@window, self, [x, y])
    elsif @direction == :up
      x = @head.x
      y = @head.y - @speed
      @head = Segment.new(@window, self, [x, y])
    end		

    @segments.push(@head)
  end

  def ate_apple?(apple)
    if Gosu::distance(@head.x, @head.y, apple.x, apple.y) < 25 then true end
  end

  def hit_wall_level_1?
    if @head.x < 15 or @head.y < 62 or @head.x > 600 or @head.y > 487 then true end
  end

  def hit_wall_level_2?
    if (@head.x > 55 and @head.x < 560 and @head.y > 172 and @head.y < 212) or (@head.x > 55 and @head.x < 560 and @head.y > 332 and @head.y < 377)
      true
    end
  end

  def hit_self?
    segments = Array.new(@segments)
    segments.pop(9)
    segments.each do |segment|
      if Gosu::distance(@head.x, @head.y, segment.x, segment.y) <= 25
        return true
      else
        next
      end
    end
    false
  end

  def teleport_level_2
    if @head.x < 0 then @head.x = 615
    elsif @head.x > 615 then @head.x = 0
    elsif @head.y < 47 then @head.y = 502
    elsif @head.y > 502 then @head.y = 47
    end
  end

  def update
    unless @speed == 0
      turn
      @segments.shift unless @length > 0
    end
  end

  def draw
    @segments.each { |segment| segment.draw }
  end
end