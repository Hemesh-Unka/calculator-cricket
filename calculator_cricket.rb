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
  attr_accessor :owner_name, :decision, :total_runs, :players, :wickets

  def initialize
    @owner_name = ""
    @decision = ""
    @players = []
    @total_runs = 0
    @wickets = 0
  end

  def create_team
    (1..11).each { |x| @players << Player.new(@owner_name, x) }
  end

  def total_runs
    @total_runs = @players.inject(0) { |sum, n| sum + n.player_runs }
  end
end

class Game
  def initialize
    @p1 = Team.new
    @p2 = Team.new
    @overs_to_play = 50
    @balls = 0

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
    print ".....and it is #{computer}. "

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
    teams = @p1.decision == "bat" ? [@p1, @p2] : [@p2, @p1] # return array with team who is batting first

    teams.each do |team|
      team.create_team  # create team
      bat(team)  # send teams into bat
      scorecard(team) # display scorecard and results
    end
  end

  def overs_played
    (@balls / 6).floor + (@balls % 6.0 / 10)
  end

  def scorecard(team)
    line_width = 50
    puts ""
    puts "--------------------------------------------------".ljust(line_width / 2)
    puts "Team #{team.owner_name}".center(line_width)
    puts "--------------------------------------------------".ljust(line_width / 2)
    team.players.each do |player|
      puts ("#{player.player_name}".ljust(line_width / 2) + ("#{player.player_runs}".rjust(line_width / 2)))
      #break if overs == 50
    end
    puts (("TOTAL (#{team.wickets == 10 ? "all out" : "for #{team.wickets} wkts"}, #{overs_played} overs)".ljust(line_width / 2)) + ("#{team.total_runs}".rjust(line_width / 2)))
  end

  def over
    (0...6).to_a.map { (0..6).to_a.sample }
  end

  def bat(team)
    currently_batting = team.players[0..1] # send first two players into bat

      (0...@overs_to_play).each do # iterate overs (Can be specified)
          over.each do |y| # iterate balls (6)
            break if team.wickets == 10 # stop the game!
            @balls += 1
            if y == 0 # wicket
              team.wickets += 1
              currently_batting[0] = team.players[team.wickets + 1] # send in the next player to bat
            elsif y.odd? # swap players around if odd runs scored
              currently_batting[0], currently_batting[1] = currently_batting[1], currently_batting[0]
              currently_batting[0].add_runs(y)
            else
              currently_batting[0].add_runs(y)
            end
          end
      end
    team.total_runs
  end

  def input(string)
    puts string
    print "> "
    gets.chomp
  end
end

def clear_screen
  return print "\e[H\e[2J"
end

game = Game.new
