require 'pry-byebug'

class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class ChessBoard
  attr_reader :board
  def initialize
    @board = Array.new
    @current_board = Array.new
  end
  
  def draw_board
    count = 1
    (0...7).each do |i|
      p_board = ""
      (0...13).each do |j|
        if (i.zero? && j.zero?) || (i.even? && j.even?) || (i.odd? && (j.zero? || j%4 == 0))
          p_board += "*"
        elsif (i.odd? && (j%2==0 && j%4!=0))
          p_board += count.to_s
          count+=1
        else
          p_board += " "
        end
      end
      @board << p_board
    end
  end

  def update_board(pos, type, name)
    until pos.to_s.match?(/\b[1-9]\b/) && @current_board[pos.to_i].nil?
      puts "Invalid position, please input again: "
      pos = gets.chomp
    end
    @board.each_with_index do |b, i|
      next if i.even? || i.zero?
      b.sub!(pos, type)
    end
    @current_board[pos.to_i] = type
    puts @board
    if check_win(type)
      puts "Player #{name} WIN!"
      true
    else
      false
    end
  end

  private

  def check_win(type)
    if [
        @current_board[1],
        @current_board[2],
        @current_board[3]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[4],
      @current_board[5],
      @current_board[6]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[7],
      @current_board[8],
      @current_board[9]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[1],
      @current_board[4],
      @current_board[7]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[2],
      @current_board[5],
      @current_board[8]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[3],
      @current_board[6],
      @current_board[9]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[1],
      @current_board[5],
      @current_board[9]
    ].all?{_1 == type}
      true
    elsif [
      @current_board[3],
      @current_board[5],
      @current_board[7]
    ].all?{_1 == type}
      true
    else
      false
    end
  end
end

module Game
  def self.start
    puts "Please input name of player 1:"
    name1 = gets.chomp
    player1 = Player.new(name1)
    puts "Please input name of player 2:"
    name2 = gets.chomp
    player2 = Player.new(name2)
    puts "------------------------------"
    chess_board = ChessBoard.new
    chess_board.draw_board
    puts chess_board.board
    puts "------------------------------"
    puts "Player #{player1.name} please input position:"
    pos = gets.chomp
    until pos.to_s.match?(/\b[1-9]\b/)
      puts "Invalid position, please input again: "
      pos = gets.chomp
    end
    type = "X"
    name = player1.name
    until chess_board.update_board(pos, type, name)
      type = type == "X" ? "O" : "X"
      name = name == player1.name ? player2.name : player1.name
      puts "Player #{name} please input position:"
      pos = gets.chomp
    end
    puts "Do you want to play new game? (Y/N): "
    want = gets.chomp
    return if want.downcase != "y"
    start
  end
end

Game.start
