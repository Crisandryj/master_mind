class Player
    attr_reader :colors

  def initialize(name)
    @name = name
  end 
  
    def createGameCode
      count = 0
      until count == 4
      letter = gets.chomp
      @game.code << letter
      count += 1
      end
      
    end 
  
  end