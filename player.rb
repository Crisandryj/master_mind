class Player
    attr_reader :colors

  def initialize(name)
    @name = name
  end 

  def createGameCode
    code = []
    count = 0
    until count == 4
    letter = gets.chomp
    code << letter
    count += 1
    end
    code
  end 

  def guessCombo
    guess = []
    count = 0
    until count == 4
    letter = gets.chomp
    guess << letter
    count += 1
    end
    guess
  end
  
end
