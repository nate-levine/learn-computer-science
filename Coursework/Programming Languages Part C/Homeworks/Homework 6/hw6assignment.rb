# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # (2) The constant All_My_Pieces should be declared here
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                  rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                  [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                  [[0, 0], [0, -1], [0, 1], [0, 2]]],
                  rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                  rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                  rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                  rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
                  rotations([[0, 0], [1, 0], [-1, 0], [0, 1], [1, 1]]), # (special 1) turtle
                  [[[0, 0], [-2, 0], [-1, 0], [1, 0], [2, 0]], # longer (only needs two)
                  [[0, 0], [0, -2], [0, -1], [0, 1], [0, 2]]],
                  rotations([[0, 0], [1, 0], [0, 1]])] # small L
  
  # your enhancements here
  
  # (2) Redefine next_piece to use MyPiece definition of All_My_Pieces
  def self.next_piece (board)
    # Set the cheat flag back to false after
    # If the cheat flag is raised, make the next piece a cheat piece
    if board.cheat_flag
      board.cheat_flag = false
      MyPiece.new([[[0, 0]]], board)
    else
      MyPiece.new(All_My_Pieces.sample, board)
    end
  end

  # (2) Initialize instance variables from super-class Piece
  def initialize (point_array, board)
    super(point_array, board)
  end
end

class MyBoard < Board
  # your enhancements here

  # (1) Initialize instance variables from super-class Board
  def initialize (game)
    super(game)
    # (2) Override current_block with MyPiece instead of Piece
    @current_block = MyPiece.next_piece(self)
    # (3) Cheat flag to keep track of whether the next piece should be a cheat piece or not
    @cheat_flag = false
  end

  # (2) Redefine next_piece to use class MyPiece instead of Piece
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  # (2) Now that the new special pieces have been introduced, not all of the pieces have 4 blocks
  #     The amount of indices must be variable based on how many blocks a piece has
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    # Get number of blocks in the current piece
    num_blocks = locations.length
    (0..(num_blocks - 1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  # (3) Getter for cheat_flag
  def cheat_flag
    @cheat_flag
  end
  
  # (3) Setter for cheat_flag
  def cheat_flag= x
    @cheat_flag = x
  end

  # (3) If the score is 100 or greater:
  #  - Remove 100 points from the score
  #  - Raise the cheat flag to make the next piece a cheat piece
  def cheat
    if @score >= 100 and !@cheat_flag
      @score -= 100
      @cheat_flag = true
    end
  end

  # (1) Rotate the current block twice, or 180 degrees
  def rotate_halfway
    if !game_over? and @game.is_running?
      @current_block.move(0, 0 , 2)
    end
    draw
  end
end

class MyTetris < Tetris
  # your enhancements here

  # (1) Initialize instance variables from super-class Tetris
  def initialize
    super
  end
  
  # (1) Redefine set_board to use the class MyBoard instead of Board
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # (1) Define new key binding for rotating a piec 180 degrees
  def key_bindings
    super
    # (1) Rotate 180 degrees
    @root.bind('u', proc {@board.rotate_halfway})
    # (3) Cheat
    @root.bind('c', proc {@board.cheat})
  end
end
