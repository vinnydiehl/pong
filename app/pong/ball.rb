class Ball
  attr_reader :position

  def initialize(screen_width, screen_height)
    @screen_width, @screen_height = screen_width, screen_height
    # Top Y value for the ball
    @screen_top = @screen_height - BALL_DIAMETER - 1

    @start_position = [screen_width / 2, screen_height / 2]
    reset
  end

  def reset
    @position = @start_position.map { |n| n - (BALL_DIAMETER / 2) }
    @speed = BALL_START_SPEED
    @angle = -45
  end

  def tick(paddles)
    # Move the ball
    radians = @angle * Math::PI / 180.0
    @position.x += @speed * Math.cos(radians)
    @position.y += @speed * Math.sin(radians) * (@speed < 0 ? -1 : 1)

    handle_paddle_collision(paddles)
    handle_wall_collision
    # Returns out_of_bounds to the game tick
    handle_out_of_bounds
  end

  # Bounce the ball off the paddles
  def handle_paddle_collision(paddles)
    paddles.values.each do |paddle|
      if (c = paddle.collision(@position.x, @position.y))
        # Speed up ball with each hit
        @speed *= -1.1
        # Reset to paddle edge so it doesn't get stuck
        @position.x = c.x
        # If the ball hits a paddle dead center, it bounces off with
        # angle 0. The angle gets more extreme as it approaches
        # the edge. Hitting the top half of the paddle will angle
        # it upwards, the lower half will angle it downwards.
        @angle = MAX_DEFLECTION_ANGLE * c.y
      end
    end
  end

  # Bounce the ball off the top/bottom walls
  def handle_wall_collision
    if @position.y <= 0 || @position.y >= @screen_top
      @angle *= -1
      @position.y = @position.y.clamp(0, @screen_top)
    end
  end

  def handle_out_of_bounds
    oob = out_of_bounds?
    reset if oob
    oob
  end

  # Returns nil, :left, or :right depending on if the ball has
  # gone off-screen on the x-axis
  def out_of_bounds?
    return :left if @position.x <= 0 - (BALL_DIAMETER * 2)
    return :right if @position.x >= @screen_width + BALL_DIAMETER
  end
end
