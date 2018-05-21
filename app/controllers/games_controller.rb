require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    # @letters = (0...10).map{ ('A'..'Z').to_a[rand(26)] }
    letters = ('A'..'Z').to_a.sample(10)
    @grid = letters.join(' ')
  end

  def score
    grid = params[:grid]
    word = params[:word].upcase
    @message = ''
    if included?(word, grid)
      if english_word?(word)
        @message = "Congratulation!"
      else
        @message = "This is not a english word"
      end
    else
      @message = "This is not in grid"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

end
