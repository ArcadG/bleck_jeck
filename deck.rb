# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = build_cards
  end

  def build_cards
    cards = []
    names = (2..10).to_a + %w[A K Q B]
    suits = ["\u2660", "\u2663", "\u2665", "\u2666"]
    points = points
    names.each do |name|
      suits.each do |suit|
        cards << Card.new(name, suit, points)
      end
    end
    cards.shuffle!
  end
end
