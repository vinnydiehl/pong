class Paddle
  def initialize(side, screen_width, screen_height)
    @side = side
    @screen_height = screen_height
    @screen_top = screen_height - PADDLE_HEIGHT - 1

    @x = if side == :left
      PADDLE_PADDING
    else
      screen_width - PADDLE_WIDTH - PADDLE_PADDING
    end
    @y = (@screen_height / 2) - (PADDLE_HEIGHT / 2)

    # Edge to detect collisions on
    @inside_edge = side == :left ? @x + PADDLE_WIDTH : @x - BALL_DIAMETER
  end

  def rect
    { x: @x, y: @y, w: PADDLE_WIDTH, h: PADDLE_HEIGHT }
  end

  # `direction` can be :up or :down.
  def move(direction)
    if direction == :up
      @y += PADDLE_SPEED
      @y = @screen_top if @y > @screen_top
    else
      @y -= PADDLE_SPEED
      @y = 0 if @y < 0
    end
  end

  # Returns nil if there's no collision, otherwise returns an array with
  # the x-value of the edge of the paddle, and the y-value on the paddle
  # that the collision happened at.
  #
  # If hit directly in the middle of the paddle, the y-value is 0. If at
  # the very top it's 1, and the very bottom is -1.
  def collision(ball_x, ball_y)
    # Make sure ball is in vertical bounds
    return if ball_y < @y || ball_y > @y + PADDLE_HEIGHT
    # Make sure ball has touched the inside edge of the paddle
    return unless (@side == :left && ball_x <= @inside_edge &&
                   ball_x + BALL_DIAMETER >= @inside_edge) ||
                  (@side == :right && ball_x >= @inside_edge &&
                   ball_x - BALL_DIAMETER <= @inside_edge)
    # If we've made it this far, we have a collision

    paddle_center = PADDLE_HEIGHT / 2
    # Y-value vertically from the midpoint of the paddle
    paddle_y_px = ball_y - @y - paddle_center

    [@inside_edge, paddle_y_px / paddle_center]
  end
end
