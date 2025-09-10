class PongGame
  def render_game
    render_background
    render_paddles
    render_ball
  end

  def render_background
    @primitives << {
      primitive_marker: :solid,
      x: 0, y: 0,
      w: @screen_width, h: @screen_height,
      r: 63, g: 63, b: 63,
    }
  end

  def render_paddles
    @paddles.values.each do |paddle|
      @primitives << {
        primitive_marker: :solid,
        **paddle.rect,
        r: 255, g: 255, b: 255,
      }
    end
  end

  def render_ball
    @primitives << {
      x: @ball.position.x, y: @ball.position.y,
      w: BALL_DIAMETER, h: BALL_DIAMETER,
      path: "sprites/circle.png",
    }
  end
end
