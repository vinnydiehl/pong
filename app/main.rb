SCENES = %w[game].freeze

%w[constants ball pong].each { |f| require "app/pong/#{f}.rb" }

%w[scenes render].each { |dir| SCENES.each { |f| require "app/pong/#{dir}/#{f}.rb" } }

def tick(args)
  args.state.game ||= PongGame.new(args)
  args.state.game.tick
end
