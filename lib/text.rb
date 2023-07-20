class Text
    def clear
        system 'cls'
    end
    def colorize(text, color_code)
        "\e[#{color_code}m#{text}\e[0m"
    end
    def startMenu
        puts "1. New Game"
        puts "2. Load Game"
        puts "3. Exit"
        print "Please select an option: "
    end
    def game(guessNumber, display, guesses)
        puts "\e[33mIncorrect guesses remaining: #{guessNumber}\e[0m"
        puts "Letters guessed: #{guesses.join(', ')} "
        puts display.join("")
        print "Enter a letter, or type save  to save progress:"
    end
end
