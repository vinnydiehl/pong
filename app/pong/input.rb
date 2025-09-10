class PongGame
  def handle_keyboard_inputs
    if @kb.key_down_or_held?(:up)
      @paddles[:right].move(:up)
    elsif @kb.key_down_or_held?(:down)
      @paddles[:right].move(:down)
    end

    if @kb.key_down_or_held?(:w)
      @paddles[:left].move(:up)
    elsif @kb.key_down_or_held?(:s)
      @paddles[:left].move(:down)
    end
  end
end
