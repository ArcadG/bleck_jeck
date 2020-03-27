module Points
  def assign_points
    if @name.is_a?(String)
      @points = 10
    else  
      @points = @name
    end
  end
end