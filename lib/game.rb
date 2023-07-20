require_relative 'text.rb'
require 'yaml'	

class Game
    def initialize
        @text = Text.new
    end

    # This method is the option menu of the game
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
        gameLoop(word, guessesNumber, rightGuessesCounter, display, guesses)
    end

    # This method is the main game loop
    def gameLoop(word, guessesNumber, rightGuessesCounter, display, guesses)
        @text.clear
        while guessesNumber > 0 and rightGuessesCounter != (word.length - 1)
            @text.game(guessesNumber, display, guesses)

            # This is the input of the user
            guess = gets.chomp.downcase
            if guess.length != 1
                if guess == "save"
                    @text.clear
                    puts @text.colorize("Enter the name of the file: ", 35)
                    filePath = gets.chomp
                    @text.clear
                    saveGame(word, guessesNumber, rightGuessesCounter, display, guesses, filePath)
                    exit
                else
                    puts @text.colorize("Invalid input. Please try again.", 31)
                    sleep(1)
                    @text.clear
                    next
                end
            end

            # This is the logic of the game
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
                    rightGuessesCounter += 1
                end
                puts rightGuessesCounter
                puts @text.colorize("Correct guess!", 32)
            end
            sleep(1)
            @text.clear
        end
        if guessesNumber == 0
            puts @text.colorize("You lost! The word was #{word}", 94)
        else
            puts @text.colorize("You won! The word was #{word}", 32)
        end
    end

    def loadGame
        # This is the list of saved games
        savedGame = Dir.glob(File.join("./saved", '*.yaml')).map { |file| File.basename(file, '.yaml') }
        puts @text.colorize("Choose your save [1 - #{savedGame.length}]:", 35)
        savedGame.each_with_index do |file, index|
            puts "#{index + 1}. #{file}"
        end
        while true
            option = gets.chomp
            if option.to_i <= savedGame.length
                break
            else
                puts @text.colorize("Invalid option. Please try again.", 31)
            end
        end
        # This loads the saved game
        data = YAML.load(File.read("./saved/#{savedGame[option.to_i - 1]}.yaml"))
        word = data["word"]
        guessesNumber = data["guesseNumber"]
        rightGuessesCounter = data["rightGuessesCounter"]
        display = data["display"]
        guesses = data["guesses"]
        gameLoop(word, guessesNumber, rightGuessesCounter, display, guesses)
    end

    def saveGame(word, guessesNumber, rightGuessesCounter, display, guesses, filePath)
        # This is the data that will be saved
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


