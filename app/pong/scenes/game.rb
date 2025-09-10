class PongGame
  def game_init
    @ball = Ball.new(@screen_width, @screen_height)
    render_game_init
  end

  def game_tick; end
end
