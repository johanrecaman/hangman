require_relative 'text.rb'

class Game
    def initialize
        @text = Text.new
    end

    def start
        @text.intro
        @text.startMenu
        while true
            option = gets.chomp
            if option == "1"
                newGame
            elsif option == "2"
                loadGame
            elsif option == "3"
                exit
            else
                puts "Invalid option. Please try again."
            end
        end
    end
    def newGame
        guesses = 10
        words = filterWords
        word = randomWord(words)
        display = ["_"] * (word.length - 1)
        counter = 0
        while guesses > 0 and counter != (word.length - 1)

            @text.game(guesses, display)

            guess = gets.chomp.downcase
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
                puts "Good guess!"
                for index in positions do
                    display[index] = guess
                    counter += 1
                end
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
          if line.length >= 5 && line.length <= 12
            words.push(line)
          end
        end
        words
      end
      
      def randomWord(words)
          selected_word = words[rand(words.length)]
          selected_word
      end
end


