file_data = File.read("google-10000-english-no-swears.txt").split

# p file_data

def select_random_word(file)
    five_twelever_letter_word = file.select {|word| word.length >= 5 && word.length <= 12}
    puts five_twelever_letter_word.sample
end

select_random_word file_data