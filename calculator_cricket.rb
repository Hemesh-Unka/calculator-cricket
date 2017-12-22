class Player
  attr_reader :player_runs, :player_name

  def initialize(name, number)
    @player_name = "#{name} #{number}"
    @player_runs = 0
  end

  def add_runs(runs)
    @player_runs += runs
  end
end

class Team
  attr_accessor :owner_name, :decision, :total_runs, :players, :total_runs

  def initialize
    @owner_name = ""
    @decision = ""
    @players = []
    @total_runs = 0
  end

  def create_team
      (1..11).each { |x| @players << create_player(x) }
    end

    def create_player(number)
      Player.new(@owner_name, number)
    end

  def total_team_runs
    @total_runs = @players.inject(0) { |sum, n| sum + n.player_runs }
  end
end

class Game
  def initialize
    @p1 = Team.new
    @p2 = Team.new

    start_up
  end

  def start_up
    clear_screen
    puts "Welcome to Calculator Cricket!"

    # enter names
    @p1.owner_name = input("Player 1 - Please enter your name").capitalize
    @p2.owner_name = input("Player 2 - Please enter your name").capitalize

    # random team is choosen to make the toss
    @toss_winner = [@p1, @p2].sample
    @toss_looser = @toss_winner == @p1 ? @p2 : @p1

    # winner decides heads or tails
    loop do
      @toss_winner.decision = input("#{@toss_winner.owner_name} gets to decide the toss. Please enter heads or tails to continue").downcase
      break if @toss_winner.decision == "heads" || @toss_winner.decision == "tails"
    end

    # computer decides heads or tails
    computer = ["heads", "tails"].sample
    puts ".....and it is #{computer}."

    # check if toss is the same as computer
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
  # return array who is batting first
  teams = batting_first(@p1, @p2)

  teams.each do |team|
    team.create_team
    # send in each team to bat
    bat(team)
    scorecard(team)
  end
end

def scorecard(team)
  line_width = 45
  puts ""
  puts "---------------------------------------------"
  puts "Team #{team.owner_name}"
  puts "---------------------------------------------"
  team.players.each { |x| puts ("#{x.player_name}".ljust(line_width / 2) + ("#{x.player_runs}".rjust(line_width / 2))) }
  puts (("TOTAL  (for #{}, #{} overs)".ljust(line_width / 2)) + ("#{team.total_runs}".rjust(line_width / 2)))
  puts "Fall"
end

def over
  (0...6).to_a.map { (0..6).to_a.sample }
end

def bat(team)
  wickets = 1;
  # send in the first two players to bat
  currently_batting = team.players[0..1] if wickets == 1
    # iterate overs
    (0...50).each do
      # iterate through each ball
        over.each do |y|
          if y == 0
          break if wickets == 10
            wickets += 1
            currently_batting[0] = team.players[wickets]
          elsif y == 4
            currently_batting[0].add_runs(4)
          elsif y == 6
            currently_batting[0].add_runs(6)
          else
          if y % 2 != 0
            currently_batting[0],currently_batting[1] = currently_batting[1],currently_batting[0]
            currently_batting[0].add_runs(y)
          else
            currently_batting[0].add_runs(y)
          end
        end
      end
      break if wickets == 10
  end
  team.total_team_runs
end

  def batting_first(team_1, team_2)
    team_1.decision == "bat" ? [team_1, team_2] : [team_2, team_1]
  end

  def input(string)
    puts string
    print "> "
    return gets.chomp
  end
end

def clear_screen
  return print "\e[H\e[2J"
end

game = Game.new
