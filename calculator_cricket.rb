## Two players
## Determines who is winner at end of the game by comparing totals
## may even evolve the program to include batsmen scores

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
  def initialize(name)
    @player_assigned_name = name
    @total_runs = 0
  end

  def create_team
    team = {}
    (1..11).each { |x| team["player" + x.to_s] = create_player(x) }
    return team
  end

  def create_player(num)
    Player.new(@player_assigned_name, num)
  end

  def total_team_runs(team)
    @total_runs
  end
end

class Game
  def initialize
    @p1_name = ""
    @p2_name = ""
  end

  def start_up
    clear_screen

    puts "Welcome to Calculator Cricket!"

    # enter names
    @p1_name = input("Player 1 - Please enter your name").capitalize
    @p2_name = input("Player 2 - Please enter your name").capitalize

    # toss
    # one person is randomly selected for the toss
    decides_toss = random([@p1_name, @p2_name])

    # that person gets to choose if it is heads or tails
    loop do
      @player_toss_decision = input("#{decides_toss} - gets to decide the toss. Please enter \"heads\" or \"tails\" to continue.").downcase
      break if @player_toss_decision == "heads" || @player_toss_decision == "tails"
    end

    # now the computer gets to randomly choose heads or tails
    computer_toss = random(["heads", "tails"])
    puts ".....and it is #{computer_toss}."

    # logic to decide looser of toss
    toss_looser = decides_toss == @p1_name ? @p2_name : @p1_name

    loop do
      print computer_toss == @player_toss_decision ? "#{decides_toss} - Wins the toss." : "#{decides_toss} - Lost the toss! #{toss_looser}"
      @toss_winner_decision = input(" - Please enter either \"bat\" or \"bowl\" to continue.").downcase
      @toss_outcome = [[decides_toss, toss_looser], @toss_winner_decision]
      break if @toss_winner_decision == "bat" || @toss_winner_decision == "bowl"
      end
    main_game
  end

def input(string)
  puts string
  print "> "
  return gets.chomp
end

def main_game
  # create new teams
  team = Team.new(@toss_outcome[0][0])
  team_1 = team.create_team

  team = Team.new(@toss_outcome[0][1])
  team_2 = team.create_team

  innings(team_1)
end

def ball
  (0..6).to_a.sample
end

def over
  (0...6).to_a.map { ball }
end

def innings(team)
  on_strike = team[0]
  non_striker = team[1]

  #if odd then other player on on_strike



  puts team.inspect
  # batsmen_1 = team.player1
  # batsmen_2 = team.player2


  wickets = 0;
  total_runs = 0;
    print "["

  (0...50).each do
    over.each do |y|

      if y == 0
        print "OUT!"
      elsif y == 4
        print"4 Runs"
      elsif y == 6
        print "6 Runs"
      else
        print y
      end
        print " - "

      total_runs += y
      break if wickets == 11
      wickets += 1 if y == 0
    end
  end
  print "]"

  return [wickets, total_runs]
end

end

def random(array)
  array.sample
end

def clear_screen
  return print "\e[H\e[2J"
end

game = Game.new
game.start_up
