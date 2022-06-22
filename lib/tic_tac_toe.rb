# frozen_string_literal: true
require_relative './game'

game = Game.new

game.print_welcome_message
game.play_game
puts 'Goodbye!!!'
