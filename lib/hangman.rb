class Hangman

    def initialize(file)
        @file = file
    end

    def start
        select_random_word(@file)
    end

    private

    def select_random_word(file)
        five_twelever_letter_word = file.select { |word| word.length >= 5 && word.length <= 12 }
        puts five_twelever_letter_word.sample
    end

end

