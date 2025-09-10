class PongGame
  def game_init
    @ball = Ball.new(@screen_width, @screen_height)
    @paddles = [:left, :right].map { |d| Paddle.new(d, @screen_width, @screen_height) }
  end

  def game_tick
    @ball.tick
  end
end
