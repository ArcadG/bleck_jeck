# frozen_string_literal: true

require_relative 'points'

class Card
  attr_reader :suit, :name, :points
  include Points

  def initialize(name, suit, points)
    @name = name
    @suit = suit
    @points = points
    assign
  end

  def assign
    assign_points
  end
end
