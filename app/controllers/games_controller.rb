require "open-uri"
require "json"
class GamesController < ApplicationController
  def new
    # @letters = 10.times { rand('A'..'Z') }
    # @letters = Array.new(10) { rand('A'..'Z') }
    # ["Y", "Z", "D", "U", "Q", "E", "Z", "Y", "Q", "I"]
    @letters = [*('A'..'Z')].sample(10).join
  end

  def score
    @word = params[:new].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    ser = URI.open(url).read
    json = JSON.parse(ser)
    @grid = params[:letters]
    if included?(@word, @grid)
      if json["found"] == true
        @result = "Congratulations! #{@word} is a valid English word!"
      else
        @result = "Sorry but #{@word} does not seem to be a valid English word"
      end
    else
      @result = "Sorry but #{@word} can't be build out of #{@grid}"
    end
  end

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end
