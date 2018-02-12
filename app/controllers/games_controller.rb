
require 'json'
require 'open-uri'

URL = 'https://wagon-dictionary.herokuapp.com/'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times{@letters  << (65 + rand(25)).chr}
  end

  def score
    # raise
    @session_score = session[:answer] ||=[]
    @word = params[:word]
    @word_letters = @word.split("")
    @result_test_1 = check_letter_grid?
    search = JSON.parse(open("#{URL}#{@word}").read)
    @result_test_2 = search["found"]

    if check_letter_grid? && search["found"]
      @result = "<strong>Congratulations!</strong> #{@word.upcase} is a valid English word!"
      @score = search["length"]
    elsif check_letter_grid?
      @result = "Sorry but <strong>#{@word.upcase}</strong> does not seem to be a valid English word..."
      @score = 0
    else
      @result = "Sorry but <strong>#{@word.upcase}</strong> can't be built out of #{@letters_grid.join(",")}"
      @score = 0
    end
    @session_score << @score
  end

  def check_letter_grid?
    @letters_grid = params[:letters].split("")
    @letters_grid_test = @letters_grid.dup
    @word_letters.each do |letter|
      if @letters_grid_test.include?(letter.capitalize)
        @letters_grid_test.delete_at(@letters_grid_test.index(letter.capitalize))
      else
        return false
      end
    end
    return true
  end

  def compute_score

  end

end
