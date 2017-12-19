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

class Team(runs = 0)
  attr_accessor :owner_name

  def initialize
    @owner_name = ""
    @total_runs = runs
    @players = []
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

    # one person is randomly selected for the toss
    @toss_winner = random([@p1, @p2])
    # that person then chooses heads or tails
    loop do
      @toss_winner_decision = input("#{@toss_winner.owner_name} - gets to decide the toss. Please enter \"heads\" or \"tails\" to continue.").downcase
      break if @toss_winner_decision == "heads" || @toss_winner_decision == "tails"
    end
    #begin computer toss
    @computer_toss = random(["heads", "tails"])
    puts ".....and it is #{@computer_toss}."
    # if the call is the same as the toss then the one person gets to decide wheter to bat or bowl

    # @toss_winner = @p1
    # @toss_winner_decision = "Heads"
    # @computer_toss = "Heads"
    # @toss_winner = @p1
    # @toss_looser = @p2
    # @toss_winner_decision = "Bat"
    # @toss_looser_decision = "Bowl"

    # else the other person gets to decide




    # that person gets to choose if it is heads or tails


    # computer randomly chooses heads or tails

    # logic to decide looser of toss
    @toss_looser = @toss_winner.owner_name == @p1.owner_name ? @p2 : @p1

    loop do
      print @computer_toss == @toss_decision ? "#{@toss_winner.owner_name} - Won the toss." : "#{@toss_winner.owner_name} - Lost the toss! #{@toss_looser.owner_name}"
      @toss_winner_decision = input(" - Please enter either \"bat\" or \"bowl\" to continue.").downcase
      break if @toss_winner_decision == "bat" || @toss_winner_decision == "bowl"
    end

    # Find out who is batting first


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
