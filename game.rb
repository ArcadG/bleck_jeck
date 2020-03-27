# frozen_string_literal: true

require_relative 'deck'
require_relative 'player'
require_relative 'show_cards'
require_relative 'points'


class Game
  attr_accessor :player, :dealer, :deck, :bank, :jackpot
  include Show
  include Points

  def initialize
    @dealer = Player.new('Диллер', 100)
    @deck = Deck.new
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
      rate
    when '2'
      exit
    else
      menu
    end
  end

  private

  def rate
    player.bank -= 10
    dealer.bank -= 10
    @jackpot = 20
    deal_cards
  end

  def deal_cards
    deck = Deck.new
    #deck.each { |cart| assign_points }
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
    player.cards << deck.cards.shift
    show_cards_player
    dealer_game
  end

  def dealer_game
    dealer.cards << deck.cards.shift
    show_cards_dealer
    game_menu
  end

  def total
    puts player.name.to_s
    show_cards_player
    puts dealer.name.to_s
    open_cards
  end
end
Game.new.menu
