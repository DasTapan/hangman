require_relative "./hangman"

file_data = File.read('google-10000-english-no-swears.txt').split

hangman = Hangman.new(file_data)

hangman.start