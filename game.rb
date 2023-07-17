require_relative 'text.rb'

class Game

    def start
        text = Text.new
        text.intro
        sleep(2)
        system("clear")
        text.startMenu
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
        words = filterWords
        word = randomWord(words)
    end
    
    def filterWords
        words = []
        File.open("words.txt", "r").each_line do |line|
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


