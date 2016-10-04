class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  #def initialize()
  #end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word.downcase ## Just in case
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(x)
    if x == nil || x.length != 1 || x =~ /[^a-z]/i
      raise ArgumentError.new
    end
    x = x.downcase
    if @wrong_guesses.include?(x)|| @guesses.include?(x)
      return false
    end
    if word.include? x
      @guesses << x
    else
      @wrong_guesses << x
    end
    return true
  end
  
  def word_with_guesses
    if guesses.length < 1
      exp = /[#{Regexp.quote(@word)}]/
    else
      exp = /[^#{Regexp.quote(@guesses)}]/
    end
    
    return word.gsub(exp ,  '-')
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
  

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end