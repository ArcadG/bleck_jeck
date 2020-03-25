# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    puts @cards.inspect
  end
  
  def build_cards
    card = []
    name = (2..10).to_a + %w[A K Q B]
    suit = ["\u2660", "\u2663", "\u2665", "\u2666"]
    name.each do |name|
      suit.each do |suit|
        card << Card.new(name, suit)
        cards = card.last 
        #@cards << cards
        puts cards.inspect
        #puts @cards.inspect

      end
      #mix
    end
  end
  #puts @cards
  def mix
    @cards.shuffle!
  end
  puts @cards
end
Deck.new.build_cards

