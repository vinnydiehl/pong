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
    @angle = -80
  end

  def tick
    # Move the ball
    radians = @angle * Math::PI / 180.0
    @position.x += @speed * Math.cos(radians)
    @position.y += @speed * Math.sin(radians)

    handle_wall_collision
  end

  # Bounce the ball off the top/bottom walls
  def handle_wall_collision
    if @position.y <= 0 || @position.y >= @screen_top
      @angle *= -1
      @position.y = @position.y.clamp(0, @screen_top)
    end
  end
end
