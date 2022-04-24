require_relative 'game'

class Computer

  def initialize (game)
    @game = game
  end 
    
    def compFirstGuess
      firstGuess = [rand(65..70).chr, rand(65..70).chr, rand(65..70).chr,rand(65..70).chr]
      firstGuess
    end

    def computerLogic(turn,nextGuess)

      if @game.letterIncluded(turn).length > 0
         @game.letterIncluded(turn).each do |k,v| 
          nextGuess.insert(k,v)
        end
      end 

      if @game.letterIncluded(turn).length > 0 && @game.includedOrIntersect.length == 0
        nextGuess.shuffle!
      end 

      if @game.includedOrIntersect.length > 0 && @game.includedOrIntersect.length > 0
          nextGuess.shuffle!
          @game.includedOrIntersect.each {|k,v| nextGuess[k] = v}
      end
      
      if nextGuess.length < 4
        until nextGuess.length == 4
        nextGuess.push(rand(65..70).chr)
        end 
      end 

      if nextGuess.include?(nil)
        nextGuess.map! {|v| v || rand(65..70).chr}
      end 

    end

end



