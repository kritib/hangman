class Hangman
  BOARDS = [
    ["   ", "   ", "   ", "   "],
    [" 0 ", "   ", "   ", "   "],
    [" 0 ", " \| ", "   ", "   "],
    [" 0 ", "\\\| ", "   ", "   "],
    [" 0 ", "\\\|/", "   ", "   "],
    [" 0 ", "\\\|/", " \| ", "   "],
    [" 0 ", "\\\|/", " \| ", "/  "],
    [" 0 ", "\\\|/", " \| ", "/ \\"],
    [" X ", "\\\|/", " \| ", "/ \\"]
  ]

  attr_accessor :secret_word

  def initialize
    @dictionary = File.open('dictionary.txt').each_line.collect(&:chomp)
  end

  def play
    print_welcome
    @secret_word = get_secret_word
    @showing = '_' * @secret_word.length
    wrong_guesses = []
    guess = ''
    puts "Word has #{secret_word.length} characters."
    until victory? || wrong_guesses.count == 8
      puts "Your board now looks like this:"
      print_hangman(wrong_guesses)
      puts @showing
      print_previous_guesses(wrong_guesses) if wrong_guesses.count >= 1
      guess = get_guess
      wrong_guesses << guess unless in_secret_word?(guess) || wrong_guesses.include?(guess)
      adjust_showing(guess) if in_secret_word?(guess)
    end

    if victory?
      puts "Congrats, boo!! You won BOOYAH!!!!!"
      puts "Boo, you da boom boom!"
    else
      print_hangman(wrong_guesses)
      puts "HAHHAHAHAHAHHAHA!!"
      puts "Look a dictionary every once in a while, ya big loser."
    end

    puts "Play again? (y/n)"
    input = gets.chomp.downcase
    if input[0] == 'y'
      play
    end
  end

  def print_hangman(wrong_guesses)
    num = wrong_guesses.count unless wrong_guesses.count < 1
    num = 0 if wrong_guesses.count < 1
    puts " -------"
    BOARDS[num].each { |body_part| puts "#{body_part}     \|" }
    puts " "
  end

  def print_welcome
    puts "Welcome to Hangman! Come one, come all! Be freeeEE!"
    puts "Computer will choose a word, and you will guess."
    puts "If you don't figure out the word in time, you will be hung."
    puts "Like a horse.... ;)"
  end

  def print_previous_guesses(wrong_guesses)
    puts "Here are the letters you've already guessed that aren't in the secret word:"
    puts wrong_guesses.join(', ')
  end

  def get_secret_word
    @secret_word = @dictionary.sample
    if secret_word.length < 6
      get_secret_word
    else
      @secret_word
    end
  end

  def victory?
    @showing == @secret_word
  end

  def in_secret_word?(guess)
    @secret_word.include?(guess)
  end

  def adjust_showing(guess)
    @secret_word.split('').each_with_index do |letter, i|
      if letter == guess
        @showing[i] = letter
      end
    end
  end

  def get_guess
    puts "What is your guess, fair lad?"
    guess = gets.chomp.downcase
    if valid?(guess)
      guess
    else
      puts "Please enter a letter from 'a'.. 'z'!"
      get_guess
    end
  end

  def valid?(guess)
    ('a'..'z').include?(guess)
  end
end

##script
h = Hangman.new
h.play


















