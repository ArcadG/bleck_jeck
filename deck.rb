# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    puts @cards.inspect
  end
  
  def build_cards
    name = (2..10).to_a + %w[A K Q B]
    suit = ["\u2660", "\u2663", "\u2665", "\u2666"]
    name.each do |name|
      suit.each do |suit|
        @cards << Card.new(name, suit)
        puts @cards.inspect
        puts name.inspect
        puts suit.inspect
      end
    end
  end
end
Card.new.build_cards

