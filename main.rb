# frozen_string_literal: true

require_relative 'lib/game/display'
require_relative 'lib/game/piece'
require_relative 'lib/game/pieces/rook'
require_relative 'lib/game/pieces/knight'
require_relative 'lib/game/pieces/bishop'
require_relative 'lib/game/pieces/queen'
require_relative 'lib/game/pieces/pawn'
require_relative 'lib/game/pieces/king'
require_relative 'lib/game/board'
require_relative 'lib/game/player'
require_relative 'lib/game'
require 'rainbow'
require 'pry-byebug'

game = Game.new
game.setup_player_names
game.play_round
