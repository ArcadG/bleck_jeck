# frozen_string_literal: true

require_relative 'card'

class Deck
  NAMES = (2..10).to_a + %w[A K Q B]
  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"].freeze

  attr_reader :cards

  def initialize
    @cards = build_cards
  end

  def build_cards
    cards = []
    points = points
    NAMES.each do |name|
      SUITS.each do |suit|
        cards << Card.new(name, suit, points)
      end
    end
    cards.shuffle!
  end
end
