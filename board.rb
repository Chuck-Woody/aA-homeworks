class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cup = Array.new(14) {Array.new} # there are 14 cups total if you include the 7 per side and the 2 on the dends
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup,idx|
      next if idx == 6 || idx == 13
      4.times do
        cup << :stone
      end
    end

  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 12
      raise 'Invalid starting cup'
    elsif @cups[start_pos].empty?
      raise 'Starting cup is empty'
    end
  end

  def make_move(start_pos, current_player_name)
    stones_in_hand = @cups[start_pos] 
    @cups[start_pos] = []

    until stones_in_hand.empty?
      cup_idx += 1
      cup_idx = 0 if cup_idx

      if cup_idx == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif cup_idx == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @[cups_idx] << stones.pop
      end
    end
      render
      next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx].length == 1
      :switch
    elsif ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    else
      ending_cup_idx
    end

  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    player_1_cups = @cups.take(5)
    player_2_cups = @cups[7..13]

    player_1_cups.all? {|cup| cup.empty?}
    player_2_cups.all? {|cup| cup.empty?}
  end

  def winner

    player_1_score = @cups[6]
    player_2_score = @cups[13]

    if player1_count == player2_count
      :draw
    else
      player1_count > player2_count ? @name1 : @name2
    end
    
  end
end
