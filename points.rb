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
end
