require 'json'
require 'rainbow'
require_relative 'lib/serializable'
require_relative 'lib/game/piece'
require_relative 'lib/game/pieces/pawn'
require_relative 'lib/game/pieces/rook'
require_relative 'lib/game/pieces/king'
require_relative 'lib/game/pieces/queen'
require_relative 'lib/game/pieces/bishop'
require_relative 'lib/game/pieces/knight'
require_relative 'lib/game/display'
require_relative 'lib/game/board'
require_relative 'lib/game/player'
require_relative 'lib/game/player/computer_player'
require_relative 'lib/game'

game = Game.new
game.setup
game.play_round
