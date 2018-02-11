class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    raise
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end
end
