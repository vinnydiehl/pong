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
end
