class PongGame
  def game_init
    @ball = Ball.new(@screen_width, @screen_height)
    @paddles = [:left, :right].map do |direction|
      [direction, Paddle.new(direction, @screen_width, @screen_height)]
    end.to_h
  end

  def game_tick
    handle_keyboard_inputs
    @ball.tick(@paddles)
  end
end
