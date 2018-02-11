require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = generate_grid(10)
  end

  def score
    @my_attempt = params[:word]
  end

  private

  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    return json['found']
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end
end
