require_relative 'game'

class Computer < Game
  
    def initialize
    end
    
    def compFirstGuess
      firstGuess = [rand(65..70).chr, rand(65..70).chr, rand(65..70).chr,rand(65..70).chr]
      firstGuess
    end

   

end



