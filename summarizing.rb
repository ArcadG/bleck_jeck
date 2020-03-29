module Summarizing

  def win
    player.total_points > dealer.total_points && player.total_points < 21 || dealer.total_points > 21
  end 

  def brute_force
    player.total_points > 21
  end

  def draw
    player.total_points == dealer.total_points
  end
  
end