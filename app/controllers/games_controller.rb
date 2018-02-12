require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = generate_grid(10)
  end

  def score
    @my_attempt = params[:word]
    @grid = params[:my_grid]
    included?(@my_attempt, @grid)
  end

  private

  def included?(attempt, grid)
    attempt.chars.all? { |letter| attempt.upcase.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    return json['found']
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end
end
