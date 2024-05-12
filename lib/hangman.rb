class Hangman
  def initialize(file)
    @file = file
    @chance = 7
    @word = select_random_word(@file)
    @word_splitted = @word.split('')
    @guess = Array.new(@word.length)
    @wrong_guess = []
    @input = []
    @fillers = ''
  end

  def start
    puts "++++++++"
    generate_fillers(@word_splitted)
    puts @word
    puts "--------"

    # je parjanta chance na sari jaichi kimba jiti na jaichi se parjanta chaliba

    while (!check_equality && @chance > 0)
    # while @chance > 0
      begin
        puts "chances remaining : #{@chance}"

        generate_fillers(@guess)
        
        p "incorrect guess :[#{@wrong_guess.join(", ")}]"
        puts "=================="
        puts 'enter a letter :'
        
        letter = gets.chomp

        unless letter.match?(/\A[a-zA-Z]\z/)
          raise StandardError
        end
      rescue StandardError
        puts 'please enter a valid letter only'
        retry
      else
        if (@word_splitted.include?(letter))
          # require 'pry-byebug';binding.pry
          index = @word_splitted.index(letter)
          @word_splitted[index] = nil
          @guess[index] = letter
        else
          @chance -= 1
          puts "OOPs! Cheems is gone forever" if(@chance == 0)
          @wrong_guess << letter
        end
      end
    end
  end

  private

  def select_random_word(file)
    five_twelever_letter_word = file.select { |word| word.length >= 5 && word.length <= 12 }
    five_twelever_letter_word.sample
  end

  def check_equality
    if (@word.split("").eql?(@guess))
      puts "Yay!! You have saved cheems!"
      true
    else
      false
    end
  end

  def generate_fillers(arr)
    fillers = arr.map do |ele|
        if(ele.nil?)
            "_"
        else
            ele 
        end        
    end
    p fillers.join(" ")
  end

  def take_input
    letter = gets.chomp
    unless letter.match?(/\A[a-zA-Z]\z/)
      puts "enter a valid letter only"
      StandardError
    else
      return letter.downcase!
    end
  end
end
