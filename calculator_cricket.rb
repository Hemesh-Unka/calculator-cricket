class Player
  attr_reader :player_runs, :player_name
  attr_accessor :player_status

  def initialize(name, number)
    @player_name = "#{name} #{number}"
    @player_runs = 0
    @player_status = "Not Out"
  end

  def add_runs(runs)
    @player_runs += runs
  end
end

class Team
  attr_accessor :owner_name, :total_runs, :players, :wickets, :fall_of_wickets

  def initialize(number)
    @owner_name = "Player #{number}"
    @players = []
    @total_runs = 0
    @wickets = 0
    @fall_of_wickets = []
  end

  def create_team
    11.times.each { |x| @players << Player.new(@owner_name, x + 1) }
  end

  def total_runs
    @total_runs = @players.inject(0) { |sum, n| sum + n.player_runs }
  end
end

class Game
  def initialize
    @players = [1,2].map { |number| Team.new(number) }
    @overs_to_play = 20

    first_run?
    #start_up
  end


  def start_up
    clear_screen
    puts "Welcome to Calculator Cricket!"

    # enter names
    @players.each { |player| player.owner_name = input("#{player.owner_name} - Please enter your name").capitalize }

    # random team is choosen to make the toss
    @players.shuffle!

    # winner decides heads or tails
    loop do
      @toss_decision = input("#{@players[0].owner_name} gets to decide the toss. Please enter heads or tails to continue").downcase
      break if @toss_decision == "heads" || @toss_decision == "tails"
    end

    # computer decides heads or tails
    computer = ["heads", "tails"].sample
    print ".....and it is #{computer}. "

    # check if toss is the same as computer (Can condense)
    print "#{@players[0].owner_name}"
    if @toss_decision == computer
      print " wins"
    else
      @players.reverse!
      print " looses"
    end
    puts " the toss"

    loop do
      @toss_decision = input("#{@players[0].owner_name} - Please enter either \"bat\" or \"bowl\" to continue.").downcase
      @players.reverse! if @toss_decision == "bowl"
      break if @toss_decision == "bat" || @toss_decision == "bowl"
    end

    main_game
  end

  def main_game
    teams = @players

    teams.each do |team|
      team.create_team  # create team
      bat(team)  # send team into bat
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
      puts ("#{player.player_name}".ljust(line_width / 2) + ("#{player.player_status}".ljust(10) + ("#{player.player_runs}".rjust(line_width / 2))))
    end
    puts (("TOTAL (#{team.wickets == 10 ? "all out" : "for #{team.wickets} wkts"}, #{overs_played} overs)".ljust(line_width / 2)) + ("#{team.total_runs}".rjust(line_width / 2)))
    puts "Fall: #{team.fall_of_wickets.join('  ')}".ljust(line_width / 2)
  end

  def over
      (0...6).to_a.map { (0..6).to_a.sample }
  end

  def bat(team)
    @balls = 0
    # send in first two players into bat
    currently_batting = team.players[0..1]
      # iterate overs (Can be specified)
      (0...@overs_to_play).each do |x|
          # iterate balls
          over.each do |y|
            @balls += 1
            # stop game
            break if team.wickets == 10 || x == @overs_to_play
            # wicket
            if y == 0
              team.wickets += 1
              team.fall_of_wickets << "#{team.wickets}-#{team.total_runs}"
              currently_batting[0].player_status = "Out"
              # send in the next player to bat
              currently_batting[0] = team.players[team.wickets + 1]
              # swap players around if odd amount runs are scored
            elsif y.odd?
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

  def clear_screen
    print "\e[H\e[2J"
  end

  def first_run?

    puts Game::count
  end
end

game = Game.new
