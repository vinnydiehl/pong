class PongGame
  def render_game
    render_background
    render_score
    render_paddles
    render_ball

    # Test code to render prediction for where the ball will
    # land on the left side (for development of the AI)

    # Only show this when the ball is moving left
    return unless @ball.speed < 0

    x, y = @ball.position
    x2 = @paddles[:left].inside_edge
    adjacent = x - x2
    # opposite = tan(angle) * adjacent
    # Add that length to the ball's y-pos to get the point
    # where the ball is headed
    y2 = y + (adjacent * Math.tan(@ball.angle.to_radians))

    # Render square where the ball will cross the paddle
    @primitives << {
      primitive_marker: :solid,
      x: x2, y: y2,
      w: BALL_DIAMETER, h: BALL_DIAMETER,
      r: 255, g: 0, b: 0,
    }

    # Render triangle used for the calculation
    @primitives << [
      # Adjacent
      {
        x: x, y: y,
        x2: x2, y2: y,
        r: 255, g: 255, b: 255,
      },
      # Opposite
      {
        x: x2, y: y,
        x2: x2, y2: y2,
        r: 255, g: 255, b: 255,
      },
      # Hypotenuse
      {
        x: x, y: y,
        x2: x2, y2: y2,
        r: 255, g: 255, b: 255,
      },
    ]
  end

  def render_background
    @primitives << {
      primitive_marker: :solid,
      x: 0, y: 0,
      w: @screen_width, h: @screen_height,
      r: 63, g: 63, b: 63,
    }

    # Center line
    @primitives << {
      primitive_marker: :solid,
      x: (@screen_width / 2) - 1, y: 0,
      w: 2, h: @screen_height,
      r: 120, g: 120, b: 120,
    }
  end

  def render_score
    [:left, :right].each do |side|
      @primitives << {
        x: @screen_width / 2 + (SCORE_PADDING * (side == :left ? -1 : 1)),
        y: @screen_height,
        text: @score[side],
        size_enum: 20,
        alignment_enum: side == :left ? 2 : 0,
        vertical_alignment_enum: 2,
        r: 255, g: 255, b: 255,
      }
    end
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
