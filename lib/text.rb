class Text
    def clear
        system 'cls'
    end
    def startMenu
        puts "1. New Game"
        puts "2. Load Game"
        puts "3. Exit"
        print "Please select an option: "
    end
    def game(guessNumber, display, rightGuesses)
        puts "Letters guessed: #{rightGuesses.join(', ')} "
        puts "Incorrect guesses remaining: #{guessNumber}"
        puts display.join("")
        print "Enter a letter, or type save  to save progress:"
    end
end
