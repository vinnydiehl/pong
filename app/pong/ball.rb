class Ball
  attr_reader :position

  def initialize(screen_width, screen_height)
    @screen_width, @screen_height = screen_width, screen_height
    # Top Y value for the ball
    @screen_top = @screen_height - BALL_DIAMETER

    @start_position = [screen_width / 2, screen_height / 2]
    reset
  end

  def reset
    @position = @start_position.map { |n| n - (BALL_DIAMETER / 2) }
    @speed = BALL_START_SPEED
    @angle = -45
  end

  def tick
    # Move the ball
    radians = @angle * Math::PI / 180.0
    @position.x += @speed * Math.cos(radians)
    @position.y += @speed * Math.sin(radians) * (@speed < 0 ? -1 : 1)

    handle_wall_collision
    handle_out_of_bounds
  end

  # Bounce the ball off the top/bottom walls
  def handle_wall_collision
    if @position.y <= 0 || @position.y >= @screen_top
      @angle *= -1
      @position.y = @position.y.clamp(0, @screen_top)
    end
  end

  def handle_out_of_bounds
    reset if out_of_bounds?
  end

  # Returns nil, :left, or :right depending on if the ball has
  # gone off-screen on the x-axis
  def out_of_bounds?
    return :left if @position.x <= 0 - (BALL_DIAMETER * 2)
    return :right if @position.x >= @screen_width + BALL_DIAMETER
  end
end
