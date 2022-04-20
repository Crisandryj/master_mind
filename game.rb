require_relative 'player'
require_relative 'computer'
class Game
    attr_reader :player, :board
    attr_accessor :code
  
    def initialize(player_class)
      @board = [[], [], [], [], [], [], [], [], [], [], [], []]
      @code = []
      @player = player_class.new('Jon')
      @intersect
      @included
    end
  
    def guessCombo(num)
      count = 0
      until count == 4
      letter = gets.chomp
      @board[num] << letter
      count += 1
      end
    end
  
    def randomCode
       code.push(rand(65..70).chr, rand(65..70).chr, rand(65..70).chr,rand(65..70).chr)
    end
  
    def letterIncluded(num)
      codeHash = Hash.new(0)
      guessHash = Hash.new(0)
      @board[num].each_with_index { |element, index| guessHash[index] = element }
      @code.each_with_index { |element, index| codeHash[index] = element }
      # if the color is included in the code
      @included = guessHash.select { |k, v| @code.include?(v)}
    end
  
    def intersect(num)
      codeHash = Hash.new(0)
      guessHash = Hash.new(0)
      @board[num].each_with_index { |element, index| guessHash[index] = element }
      @code.each_with_index { |element, index| codeHash[index] = element }
      # if the value and postion are equal
      @intersect = guessHash.select { |k, v| (codeHash.include?(k) && codeHash[k] == v) }
    end
  
    def includedOrIntersect
      # included both @intersect and @included
      @intersect.select {|k,v| @included[k] == v}
    end 

    def createGameCode
      count = 0
      until count == 4
      letter = gets.chomp
      @code << letter
      count += 1
      end
      @code
    end 
  
    def playerPlay
      num = 0
      gameCode = randomCode
      p gameCode
      until num == 12
        puts 'Player, guess the combo using letter A-E (enter one letter at a time):'
        puts "Turn: #{num + 1}"
        guessCombo(num)
        p @board
        if @board[num] == gameCode
          puts 'Player wins!'
          return
        end
        intersect(num)
        p 'Correct letter(s) out of position:'
        p letterIncluded(num).length - includedOrIntersect.length
        p 'Correct letter(s) in correct position(s):'
        p includedOrIntersect.length
  
        num += 1
      end
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

    def play
      puts "Do you want to create the code or guess the code?(guess/create)"
      answer = gets.chomp.downcase
      if answer == "guess"
        playerPlay
      elsif answer == "create"
        computerPlay
      else
        p "guess or create"
        answer = gets.chomp.downcase
      end 
     end   
  end

