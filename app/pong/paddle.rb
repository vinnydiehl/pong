class Paddle
  def initialize(side, screen_width, screen_height)
    @side = side
    @screen_height = screen_height

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
end
