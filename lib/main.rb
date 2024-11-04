# frozen_string_literal: true

require_relative 'connect_four'

class Main
  def initialize
    game = ConnectFour.new
    game.play
  end
end

Main.new
