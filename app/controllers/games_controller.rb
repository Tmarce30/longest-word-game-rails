require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = generate_grid(10)
  end

  def score
    @my_attempt = params[:word].upcase
    @grid = params[:my_grid]
    @result = message(@my_attempt, @grid)
  end

  private

  def message(attempt, grid)
    if included?(attempt, grid)
      if english_word?(attempt)
        "Congratulations #{attempt} is a valid English word!"
      else
        "Soory but #{attempt} does not seem to be a valid english word"
      end
    else
      "Sorry but #{attempt} can't be built out of #{grid.gsub(/\W/, ' ')}"
    end
  end

  def included?(attempt, grid)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
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
