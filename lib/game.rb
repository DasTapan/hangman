require_relative "./hangman"

hangman = nil

file_data = File.read('google-10000-english-no-swears.txt').split

fls = Dir.glob('saves/**/*.yaml')

# require 'pry-byebug'; binding.pry
saved_games = fls.map do |f|
    d_path, f_name = File.split(f)
    b_name = File.basename(f_name,'.*')
end

if fls.length > 0
    puts "saved games -:"
    saved_games.each {|f| puts f}
end

begin
    puts "Enter the saved game OR start a new game by typing: NEW"
    user_choice = gets.chomp
    # require 'pry-byebug'; binding.pry

    if user_choice.downcase != "new" && !saved_games.include?(user_choice)
        raise StandardError
    end
rescue
    puts "entered rescue block"
    puts "Please enter the keyword NEW or saved game file name"
    retry
else
    # require 'pry-byebug'; binding.pry

    if(user_choice.downcase == "new") 
        hangman = Hangman.new(file_data)
    else
        to_be_parsed = ""
        file = File.open("saves/#{user_choice}.yaml")

        while line = file.gets do
            to_be_parsed << line
        end

        file.close

        saved_session = Serialize::from_yaml(to_be_parsed)
        hangman = Hangman.new(nil,saved_session)
    end
end

# START the game
hangman.start