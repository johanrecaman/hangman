require 'io/console'
require_relative 'text.rb'

class Game
    def initialize
        @text = Text.new
    end

    def start
        @text.startMenu
        while true
            option = gets.chomp
            if option == "1"
                @text.clear
                newGame
            elsif option == "2"
                @text.clear
                loadGame
            elsif option == "3"
                @text.clear
                exit
            else
                puts "Invalid option. Please try again."
            end
        end
    end
    def newGame
        words = filterWords
        word = randomWord(words)

        rightGuesses = []
        guesses = 10
        rightGuessesCounter = 0
        
        display = ["_"] * (word.length - 1)
        while guesses > 0 and rightGuessesCounter != (word.length - 1)

            @text.game(guesses, display, rightGuesses)

            guess = gets.chomp.downcase
            rightGuesses.push(guess)
            positions = []

            word.chars.each_with_index do |char, index|
                if char == guess
                    positions.push(index)
                end
            end
            if positions.empty?
                guesses -= 1
                puts "No Luck!"
            else
                for index in positions do
                    display[index] = guess
                end
                rightGuessesCounter += 1
                puts "Good guess!"
            end
        end
        if guesses == 0
            puts "vc perdeu"
        else
            puts "vc ganhou"
        end
    end
    

    def filterWords
        words = []
        File.open("./words.txt", "r").each_line do |line|
          if line.length >= 7 && line.length <= 12
            words.push(line)
          end
        end
        words
      end
      
      def randomWord(words)
          selected_word = words[rand(words.length - 1)]
          selected_word
      end
end


