## Two players
## Determines who is winner at end of the game by comparing totals
## may even evolve the program to include batsmen scores

class Player
  def initialize
    @name = "Virtual Player Name"
    @runs = 0
  end
end

class Team
  def initialize(player_assigned)
    @player_assigned = player_assigned
    @team_size = 11
    @team_name = "Virtual Team Name"
    @total_runs = 0
  end
end

class Game
  def initialize
    @innings = 2
    @p1 = {}
    @p2 = {}
  end

  def start_up
    clear_screen

    # welcome
    puts "Welcome to Calculator Cricket!"

    # enter names
    puts "Player 1 - Please enter your name"
    print "> "
    @p1['name'] = gets.capitalize.chomp

    puts "Player 2 - Please enter your name"
    print "> "
    @p2['name'] = gets.capitalize.chomp

    # toss
    # one person is randomly selected for the toss
    decides_toss = random([@p1, @p2])['name']

    # that person gets to choose if it is heads or tails
    loop do
      puts "#{decides_toss} - gets to decide the toss. Please enter \"heads\" or \"tails\" to continue."
      print "> "
      @player_toss_decision = gets.downcase.chomp
      break if @player_toss_decision == "heads" || @player_toss_decision == "tails"
    end

    # now the computer gets to randomly choose heads or tails
    computer_toss = random(["heads", "tails"])
    puts ".....and it is #{computer_toss}."

    # who won the toss - Was it the same person? - Yes
    if computer_toss === @player_toss_decision
      loop do
        puts "#{decides_toss} - Wins the toss. Please enter either \"bat\" or \"bowl\" to continue."
        print "> "
        @toss_winner_decision = gets.downcase.chomp
        @toss_outcome =  [decides_toss, @toss_winner_decision]
        break if @toss_winner_decision == "bat" || @toss_winner_decision == "bowl"
      end
    # who won the toss - Was it the same person? - No
    else
      toss_looser = decides_toss == @p1['name'] ? @p2['name'] : @p1['name']
      loop do
        puts "#{decides_toss} - Lost the toss!"
        puts "#{toss_looser} - Please enter either \"bat\" or \"bowl\" to continue."
        print "> "
        @toss_winner_decision = gets.downcase.chomp
        @toss_outcome = [toss_looser, @toss_winner_decision]
        break if @toss_winner_decision == "bat" || @toss_winner_decision == "bowl"
      end
    end
    main_game
  end

def main_game
  # create new team class
  team = Team.new(@toss_outcome[0])

  puts team


  innings
end

def ball
  return (0..6).to_a.sample
end

def over
  return (0...6).to_a.map { |x| ball }
end

def innings
  wickets = 0;
  total_runs = 0;

  (0...50).each do |e|

    over.each do |y|
      if y == 0
        puts "OUT!"
      elsif y == 4
        puts "4 Runs"
      elsif y == 6
        puts "6 Runs"
      else
        puts y
      end

      total_runs += y
      break if wickets == 11
      wickets += 1 if y == 0
    end

  end
  puts wickets
  puts total_runs
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
