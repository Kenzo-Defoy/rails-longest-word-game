require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word
    url = "https://dictionary.lewagon.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  def letter_in_grid
    @answer.chars.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word].upcase
    letters_in_grid = letter_in_grid
    valid_english_word = english_word

    if !letters_in_grid
      @result = "Sorry, but #{@answer} can't be built out of #{@grid}."
    elsif !valid_english_word
      @result = "Sorry but #{@answer} does not seem to be an English word."
    else
      @result = "Congratulations! #{@answer} is a valid English word."
    end
  end
end

