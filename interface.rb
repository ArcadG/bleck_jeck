# frozen_string_literal: true

require_relative 'game'

class Interface
  attr_reader :game

  def initialize
    @game = Game.new(self)
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
      game.player_creation(input)
    when '2'
      exit
    else
      menu
    end
  end

  def game_menu
    puts '1 - Добавить карту'
    puts '2 - Пропустить ход'
    puts '3 - Вскрыть карты'
    input = gets.chomp
    case input
    when '1'
      game.add_card
    when '2'
      game.dealer_game
    when '3'
      game.total
    else
      game_menu
    end
  end

  def restart_menu
    puts 'Продолжим?'
    puts 'Нажмите: 1 - Да, 2 - Нет'
    input = gets.chomp
    case input
    when '1'
      game.restart
    when '2'
      exit
    else
      restart_menu
    end
  end
end
Interface.new.menu
