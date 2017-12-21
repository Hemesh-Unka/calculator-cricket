class Player
  def initialize(name, number, runs = 0)
    @player_name = "#{name} #{number}"
    @player_runs = runs
  end

  def add_runs(run)
    @player_runs += run
  end

  def total_player_runs
    @player_runs
  end
end

class Team
  attr_accessor :owner_name, :decision

  def initialize(runs = 0)
    @owner_name = ""
    @total_runs = runs
    @players = []
    @decision = ""
  end

  def create_team
    (1..11).each { |x| @players << create_player(x) }
  end

  def create_player(number)
    Player.new(@owner_name, number)
  end

  def total_team_runs(team)
    @total_runs = @players.reduce(:+)
  end
end

class Game
  def initialize
    @p1 = Team.new
    @p2 = Team.new
  end

  def start_up
    clear_screen

    puts "Welcome to Calculator Cricket!"

    # enter names
    @p1.owner_name = input("Player 1 - Please enter your name").capitalize
    @p2.owner_name = input("Player 2 - Please enter your name").capitalize

    # random team is choosen to make the toss
    @toss_winner = random([@p1, @p2])
    @toss_looser = @toss_winner == @p1 ? @p2 : @p1

    # winner decides heads or tails
    loop do
      @toss_winner.decision = input("#{@toss_winner.owner_name} gets to decide the toss. Please enter heads or tails to continue").downcase
      break if @toss_winner.decision == "heads" || @toss_winner.decision == "tails"
    end

    # computer decides heads or tails
    computer = random(["heads", "tails"])
    puts ".....and it is #{computer}."

    if @toss_winner.decision == computer
      puts "#{@toss_winner.owner_name} wins the toss"
    else
      @toss_looser = @toss_winner
      @toss_winner = @toss_looser == @p1 ? @p2 : @p1
      puts "#{@toss_looser.owner_name} looses the toss"
    end

    loop do
      @toss_winner.decision = input("#{@toss_winner.owner_name} - Please enter either \"bat\" or \"bowl\" to continue.").downcase
      @toss_looser.decision = @toss_winner.decision == "bat" ? "bowl" : "bat"
      break if @toss_winner.decision == "bat" || @toss_winner.decision == "bowl"
    end

    main_game
  end

def main_game



end

def ball
  (0..6).to_a.sample
end

def over
  (0...6).to_a.map { ball }
end

def bat(team)
  wickets = 0;

  (0...50).each do
    over.each do |y|

      if y == 0
        print "OUT!"
        wickets += 1
      elsif y == 4
        print"4 Runs"
      elsif y == 6
        print "6 Runs"
      else
        print y
      end
        print " - "

      break if wickets == 11
    end
  end

end

  def input(string)
    puts string
    print "> "
    return gets.chomp
  end

  def random(array)
    array.sample
  end

end

def clear_screen
  return print "\e[H\e[2J"
end

game = Game.new
game.start_up
