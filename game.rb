# frozen_string_literal: true

#require_relative 'interface'
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

  private

  def place_bet
    player.bank -= rate
    dealer.bank -= rate
    @jackpot = rate * 2
    deal_cards
  end

  def deal_cards
    @deck = Deck.new
    2.times do
      player.cards << deck.cards.shift
      dealer.cards << deck.cards.shift
    end
    player.sum_points
    dealer.sum_points
    puts player.name.to_s
    show_cards_player
    puts "Сумма Ваших очков равна: #{player.total_points}"
    puts dealer.name.to_s
    show_cards_dealer
    game_menu
  end

  def dealer_game
    dealer.sum_points
    if dealer.total_points.to_i <= 17 && dealer.cards.length < 3
      dealer.cards << deck.cards.shift
      puts dealer.name.to_s
      show_cards_dealer
      game_menu
    else
      puts "#{dealer.name}-пропускает ход"
      show_cards_dealer
      game_menu
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
    restart_menu
  end

  def restart_menu
    puts 'Продолжим?'
    puts 'Нажмите: 1 - Да, 2 - Нет'
    input = gets.chomp
    case input
    when '1'
      if player.bank < 10 || dealer.bank < 10
        puts 'У одного из играющих банк пуст'
        dealer.clear
        menu
      else
        restart
      end
    when '2'
      exit
    else
      restart_menu
    end
  end

  def restart
    dealer.clear
    player.clear
    place_bet
  end
end

# Game.new.menu
