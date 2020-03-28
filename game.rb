# frozen_string_literal: true

require_relative 'deck'
require_relative 'player'
require_relative 'show_cards'
require_relative 'points'

class Game
  attr_accessor :player, :dealer, :deck, :bank, :jackpot, :rate
  include Show
  include Points

  def initialize
    @dealer = Player.new('Диллер', 100)
  end

  def menu
    puts '-------------- БЛЕК ДЖЕК -------------------'
    puts 'Хотите сыграть?'
    puts 'Нажмите: 1 - Да. или 2 - Нет.'
    input = gets.chomp
    case input
    when '1'
      puts 'Введите ваше имя'
      input = gets.chomp.to_s
      @player = Player.new(input, 100)
      @rate = 10
      place_bet
    when '2'
      exit
    else
      menu
    end
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
    puts player.name.to_s
    show_cards_player
    puts dealer.name.to_s
    show_cards_dealer
    game_menu
  end

  def game_menu
    puts '1 - Добавить карту'
    puts '2 - Пропустить ход'
    puts '3 - Вскрыть карты'
    input = gets.chomp
    case input
    when '1'
      add_card
    when '2'
      dealer_game
    when '3'
      total
    else
      game_menu
    end
  end

  def add_card
    if player.cards.length < 3
      player.cards << deck.cards.shift
      puts player.name.to_s
      show_cards_player
      dealer_game
    else
      puts 'Вы уже набрали максимальное количество карт'
      game_menu
    end
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
    puts dealer.name.to_s
    open_cards
    game_total
  end

  def game_total
    dealer.sum_points
    player.sum_points
    if player.total_points == dealer.total_points ||
       player.total_points > 21 && dealer.total_points > 21
      puts 'Ничья'
      player.bank += rate
      dealer.bank += rate
      puts "В банке #{player.bank}$"
    elsif player.total_points > dealer.total_points && player.total_points < 22 ||
          player.total_points < dealer.total_points && dealer.total_points > 21
      puts 'Вы выиграли'
      player.bank += jackpot
      puts "В банке #{player.bank}$"
    else
      puts 'Вы проиграли'
      puts "В банке #{player.bank}$"
      dealer.bank += jackpot
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

Game.new.menu
