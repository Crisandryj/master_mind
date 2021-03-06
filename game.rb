require_relative 'player'
require_relative 'computer'

class Game 
    attr_accessor :code, :board, :intersect, :included
  
    def initialize(name,computer_class)
      @board = [[], [], [], [], [], [], [], [], [], [], [], []]
      @code = []
      @intersect
      @included
      @player = Player.new(name)
      @computer = Computer.new(self)
      @codeHash = Hash.new(0)
      @guessHash = Hash.new(0)
    end
    
    def createHash(turn)
      @code.each_with_index { |element, index| @codeHash[index] = element }
      @board[turn].each_with_index { |element, index| @guessHash[index] = element }
    end 

     # check if the color is included in the code    
    def letterIncluded(turn)
      createHash(turn)
      @included = @guessHash.select { |k, v| @code.include?(v)}
    end

    # check if the value and postion are equal
    def intersect(turn)
      createHash(turn)
      @intersect = @guessHash.select { |k, v| (@codeHash.include?(k) && @codeHash[k] == v) }
    end

    # check if both included both @intersect and @included
    def includedOrIntersect
      @intersect.select {|k,v| @included[k] == v}
    end 

    def feedback(turn)
      letterIncluded(turn)
      intersect(turn)
      p 'Correct letter(s) out of position:'
      p letterIncluded(turn).length - includedOrIntersect.length
      p 'Correct letter(s) in correct position(s):'
      p includedOrIntersect.length
    end 

    def randomCode
      code.push(rand(65..70).chr, rand(65..70).chr, rand(65..70).chr,rand(65..70).chr)
    end

    def playerWins?(turn,gameCode)
      @board[turn] == gameCode
    end 

    def compWins?(turn,gameCode)
      if @board[turn] == gameCode
        puts 'Computer wins!'
        return
      end
    end 

    def playerMaker
      nextGuess = @computer.compFirstGuess
      turn = 0
      puts "Create code:"
      @code.replace(@player.createGameCode)
      gameCode = @code
      @board[turn].replace(nextGuess)
      until turn == 12
        p gameCode
        puts 'Computer, guess the combo using letter A-E (enter one letter at a time):'
        puts "Turn: #{turn + 1}"
        @board[turn].replace(nextGuess)
        nextGuess = []
        p @board
        letterIncluded(turn)
        intersect(turn)
        @computer.computerLogic(turn,nextGuess) 
        compWins?(turn,gameCode)
        turn += 1
      end

    end

    def playerBreaker(gameCode)
      turn = 0
      until turn == 12
        p @board
        puts "Turn: #{turn +1}"
        @board[turn].replace(@player.guessCombo)
        return puts "Player Wins!!!" if playerWins?(turn,gameCode)
        feedback(turn)
        turn += 1
      end
    end 

    def codeBreakerOrMaker
      puts "Do you want to make the code or break the code?(M/B)"
      answer = gets.chomp.downcase
      if answer == "b"
        gameCode = randomCode
        p gameCode
        puts 'Player, guess the combo using letter A-E (enter one letter at a time):'
        playerBreaker(gameCode)
      elsif answer == "m"
        playerMaker
      else
        return
      end 
     end  

  end

