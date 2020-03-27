# frozen_string_literal: true

class Player
  attr_accessor :name, :bank, :cards

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end
end
