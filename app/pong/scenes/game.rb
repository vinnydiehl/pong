class PongGame
  def game_init
    @ball = Ball.new(@screen_width, @screen_height)
    @paddles = [:left, :right].map do |direction|
      [direction, Paddle.new(direction, @screen_width, @screen_height)]
    end.to_h

    @score = { left: 0, right: 0 }
  end

  def game_tick
    handle_keyboard_inputs
    handle_scoring(@ball.tick(@paddles))
  end

  def handle_scoring(out_of_bounds)
    if out_of_bounds
      @score[out_of_bounds == :left ? :right : :left] += 1
    end
  end
end
