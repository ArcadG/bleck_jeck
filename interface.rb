# frozen_string_literal: true

require_relative 'game'

class Interface
  attr_reader :g

  def initialize
    @g = Game.new
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
      @g.player_creation(input)
    when '2'
      exit
    else
      menu
    end
  end

  private

  def game_menu
    puts '1 - Добавить карту'
    puts '2 - Пропустить ход'
    puts '3 - Вскрыть карты'
    input = gets.chomp
    case input
    when '1'
      @g.add_card
    when '2'
      @g.dealer_game
    when '3'
      @g.total
    else
      game_menu
    end
  end
end
Interface.new.menu
