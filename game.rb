# frozen_string_literal: true

# require_relative 'interface'
require_relative 'deck'
require_relative 'player'
require_relative 'show_cards'
require_relative 'summarizing'

class Game
  attr_reader :player, :dealer, :deck, :bank, :jackpot, :rate
  include Show
  include Summarizing

  def initialize
    @dealer = Player.new('Диллер', 100)
    @rate = 10
  end

  def player_creation(input)
    @player = Player.new(input, 100)
    place_bet
  end

  # private

  def place_bet
    player.bank -= rate
    dealer.bank -= rate
    @jackpot = rate * 2
  end

  def deal_cards(interface)
    @deck = Deck.new
    2.times do
      player.cards << deck.cards.shift
      dealer.cards << deck.cards.shift
    end
    player.sum_points
    puts player.name.to_s
    show_cards_player
    puts "Сумма Ваших очков равна: #{player.total_points}"
    puts dealer.name.to_s
    show_cards_dealer
    interface.game_menu
  end

  def add_card
    player.cards << deck.cards.shift if player.cards.length < 3
    player.sum_points
    if player.total_points > 21
      show_cards_player
      puts "Сумма Ваших очков равна: #{player.total_points}"
      game_total
    end
  end

  def dealer_game(interface)
    dealer.sum_points
    player.sum_points
    if dealer.total_points.to_i <= 17 && dealer.cards.length < 3 &&
       player.total_points.to_i < 21
      dealer.cards << deck.cards.shift
      total
    else
      puts "#{dealer.name}-пропускает ход"
      show_cards_dealer
      interface.game_menu
    end
  end

  def total
    puts player.name.to_s
    show_cards_player
    puts "Сумма Ваших очков равна: #{player.total_points}"
    puts dealer.name.to_s
    open_cards
    dealer.sum_points
    puts "Сумма очков #{dealer.name} равна: #{dealer.total_points}"
    game_total
  end

  def game_total
    dealer.sum_points
    player.sum_points
    if win
      puts 'ВЫ ВЫИГРАЛИ'
      player.bank += jackpot
      puts "В банке #{player.bank}$"
    elsif brute_force || player.total_points < dealer.total_points
      puts 'ВЫ ПРОИГРАЛИ'
      dealer.bank += jackpot
      puts "В банке #{player.bank}$"
    elsif draw
      puts 'НИЧЬЯ'
      player.bank += rate
      dealer.bank += rate
      puts "В банке #{player.bank}$"
    end
    interface.restart_menu
  end

  def restart(interface)
    if player.bank < 10 || dealer.bank < 10
      puts 'У одного из играющих банк пуст'
      dealer.clear
      interface.menu
    else
      dealer.clear
      player.clear
      place_bet
    end
  end
end

# Game.new.menu
