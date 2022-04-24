class Player

  def initialize(name)
    @name = name
  end 

  def createGameCode
    code = gets.chomp.upcase.split('')
    until code.length == 4
      p "Please enter 4 letters only (A-F)"
      code = gets.chomp.upcase.split('')
      end 
    code
  end 

  def guessCombo
    guess = gets.chomp.upcase.split('')
    until guess.length == 4
      p "Please enter 4 letters only (A-F)"
      guess = gets.chomp.upcase.split('')
      end 
    guess
  end
  
end


