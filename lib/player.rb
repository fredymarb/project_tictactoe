class Player
  attr_accessor :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def make_move
    print "#{@name}, enter a position (1-9): "
    gets.chomp
  end
end
