class Ball
  attr_reader :position

  def initialize(screen_width, screen_height)
    @start_position = [screen_width / 2, screen_height / 2]
    reset
  end

  def reset
    @position = @start_position.map { |n| n - (BALL_DIAMETER / 2) }
  end
end
