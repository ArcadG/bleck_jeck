# frozen_string_literal: true

class Player
  attr_accessor :name, :bank, :cards, :total_points
  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def sum_points
    @total_points = 0
    @cards.each { |card| @total_points += card.points }
  end

  def clear
    @cards.clear
  end
end
