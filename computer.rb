require_relative 'game'
require_relative 'player'

class Computer < Game
  
    def initialize(game)
    @game = game
    end    

    def guess

    end 
    
    def computerPlay
    nextGuess = [rand(65..70).chr, rand(65..70).chr, rand(65..70).chr,rand(65..70).chr]
    num = 0
    gameCode = createGameCode
    until num == 12
      p gameCode
      puts 'Computer, guess the combo using letter A-E (enter one letter at a time):'
      puts "Turn: #{num}"
      @board[num].replace(nextGuess)
      nextGuess = []
      p @board
      if @board[num] == gameCode
        puts 'Computer wins!'
        return
      end
      intersect(num)
      letterIncluded(num)
      if letterIncluded(num).length > 0
        letterIncluded(num).each do |k,v| 
          nextGuess.insert(k,v)
        end
      end 
        if letterIncluded(num).length > 0 && includedOrIntersect.length == 0
          nextGuess.shuffle!
        end 

        if includedOrIntersect.length > 0 && includedOrIntersect.length > 0
            nextGuess.shuffle!
            includedOrIntersect.each {|k,v| nextGuess[k] = v}
        end
        
        if nextGuess.length < 4
          until nextGuess.length == 4
          nextGuess.push(rand(65..70).chr)
          end 
        end 

        if nextGuess.include?(nil)
          nextGuess.map! {|v| v || rand(65..70).chr}
        end 
      num += 1
    end
  end 
end