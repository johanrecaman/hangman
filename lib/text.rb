class Text
    
    def intro
        puts "Welcome to Hangman!"
        puts "You have 10 guesses to guess the word."
        puts "If you guess the word before you run out of guesses, you win!"
        puts "If you run out of guesses before you guess the word, you lose!"
        puts "Good luck!"
    end
    
    def startMenu
        puts "1. New Game"
        puts "2. Load Game"
        puts "3. Exit"
        print "Please select an option: "
    end
    def game(guesses, display)
        puts "Letters guessed: "
        puts "Incorrect guesses remaining: #{guesses}"
        puts display.join("")
    end
end
