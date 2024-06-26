require_relative './dictionary'
require_relative './serialize'

class Hangman
  def initialize(file, saved_session = {})
    if(file.nil?)
      @chance = saved_session[:chance]
      @word = saved_session[:word]
      @hint = saved_session[:hint]
      @word_splitted = saved_session[:word_splitted]
      @guess = saved_session[:guess]
      @wrong_guess = saved_session[:wrong_guess]
      @fillers = saved_session[:fillers]
    else
      @file = file
      @chance = 7
      @word = select_random_word(@file)
      @hint = Dictionary::get_hint(@word)
      @word_splitted = @word.split('')
      @guess = Array.new(@word.length)
      @wrong_guess = []
      @input = []
      @fillers = ''  
    end
  end

  def start
    # require 'pry-byebug';binding.pry

    puts ""
    puts "You need to guess the word correctly in 7 attempts"
    puts ""
    puts "This is only way to save Cheems"
    puts ""
    # je parjanta chance na sari jaichi kimba jiti na jaichi se parjanta chaliba

    while (!check_equality && @chance > 0)
    # while @chance > 0
      begin
        puts "Hint: '#{@hint}'"
        puts ""
        puts "chances remaining : #{@chance}"
        puts ""
        generate_fillers(@guess)
        
        p "incorrect guess :[#{@wrong_guess.join(", ")}]"
        puts ""
        puts "enter a letter or write 'SAVE' to save the game and exit :"
                
        # letter = gets.chomp
        letter = gets.chomp
        if(letter.downcase == "save")
          puts "saving the game... & exiting.."
          sleep(2)
          Serialize.to_yaml({
            :chance => @chance,
            :word => @word,
            :hint => @hint,
            :word_splitted => @word_splitted,
            :guess => @guess,
            :wrong_guess => @wrong_guess,
            :fillers => @fillers
          }) 
          break
        else
          if letter.length > 1 || !letter.match?(/\A[a-zA-Z]\z/)
            raise StandardError
          end  
        end    

      rescue StandardError
        puts 'please enter a valid single letter only'
        retry
      else
        if (@word_splitted.include?(letter))
          index = @word_splitted.index(letter)
          @word_splitted[index] = nil
          @guess[index] = letter
        else
          @chance -= 1
          if(@chance == 0)
            puts ""
            puts "OOPs! Cheems is gone forever"
            puts ""
            puts "The word wasa '#{@word.upcase}'"
          end
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
      puts ""
      puts "Yay!! You have saved cheems!"
      puts ""
      puts "The word wasa '#{@word.upcase}'"
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
end
