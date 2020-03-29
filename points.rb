# frozen_string_literal: true

module Points
  def assign_points
    @points = if @name == 'A'
                11
              elsif @name.to_i.zero?
                10
              else
                @name
              end
  end

  def points_ace
    if @cards.size == 2 && @cards.last.name == 'A' && @total_points > 21
      @total_points -= 10
    elsif @cards.size == 3 && @cards.last.name == 'A' && @total_points > 21
      @total_points -= 10
    end
  end
end
