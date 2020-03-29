# frozen_string_literal: true

require_relative 'points'

class Player
  attr_accessor :bank
  attr_reader :name, :cards, :total_points
  include Points

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def sum_points
    @total_points = 0
    @cards.each { |card| @total_points += card.points }
    points_ace
  end

  def clear
    @cards.clear
  end
end
