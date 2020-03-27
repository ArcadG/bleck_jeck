# frozen_string_literal: true

module Show
  def show_cards_player
    player.cards.each do |card|
      puts "#{card.name}#{card.suit}"
    end
  end

  def show_cards_dealer
    dealer.cards.each do |card|
    puts '**'
    end
  end

  def open_cards 
    dealer.cards.each do |card|
      puts "#{card.name}#{card.suit}"
    end
  end
end
