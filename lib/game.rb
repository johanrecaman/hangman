require_relative 'text.rb'
require 'yaml'	

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

        guesses = []
        guessesNumber = 10
        rightGuessesCounter = 0
        
        display = ["_"] * (word.length - 1)
        while guessesNumber > 0 and rightGuessesCounter != (word.length - 1)

            @text.game(guessesNumber, display, guesses)

            guess = gets.chomp.downcase
            if guess.length != 1
                if guess == "save"
                    puts @text.colorize("Enter the name of the file: ", 35)
                    filePath = gets.chomp
                    saveGame(word, guessesNumber, rightGuessesCounter, display, guesses, filePath)
                    exit
                else
                    puts @text.colorize("Invalid input. Please try again.", 31)
                    sleep(1)
                    @text.clear
                    next
                end
            end

            if word.chars.any? { |char| char == guess }
                guesses.push("\e[32m #{guess}\e[0m")
            else
                guesses.push("\e[94m #{guess}\e[0m")
            end
            positions = []

            word.chars.each_with_index do |char, index|
                if char == guess
                    positions.push(index)
                end
            end
            if positions.empty?
                guessesNumber -= 1
                puts @text.colorize("Incorrect guess!", 94)
            else
                for index in positions do
                    display[index] = guess
                end
                rightGuessesCounter += 1
                puts @text.colorize("Correct guess!", 32)
            end
            sleep(1)
            @text.clear
        end
        if guessesNumber == 0
            puts @text.colorize("You lost! The word was #{word}", 94)
        else
            puts @text.colorize("You won!", 32)
        end
    end
    
    def saveGame(word, guessesNumber, rightGuessesCounter, display, guesses, filePath)
        data = {
            "word" => word,
            "guesseNumber" => guessesNumber,
            "rightGuessesCounter" => rightGuessesCounter,
            "display" => display,
            "guesses" => guesses
        }
        File.open("./saved/#{filePath}.yaml", "w") do |file|
            file.write(YAML.dump(data))
        end
        puts @text.colorize("Game saved!", 35)
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


