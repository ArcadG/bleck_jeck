# frozen_string_literal: true

class Card
  attr_reader :suit, :name
  def initialize(name, suit)
    @name = name
    @suit = suit
  end
end

