class TicTacToe
    @@playerOneWon = 0
    @@playerTwoWon = 0
    attr_reader :playerOneWon, :playerTwoWon, :table
    def initialize(player1="Player 1", player2="Player 2")
        @table = Array.new(3) {Array.new(3, 3)}
        @player1 = player1
        @player2 = player2
    end

    def inspect
        puts "Player 1 won #{@@playerOneWon} games."
        puts "Player 2 won #{@@playerTwoWon} games."
    end

end

class Games
    @@gamesPlayed = 0
    attr_reader :gamesPlayed
    def initialize(player1="Player 1", player2="Player 2")
        @player1 = player1
        @player2 = player2
        @game = TicTacToe.new(player1, player2)
        beginGame
    end

    def show_table
        @game.table.each do |row|
            row.each { |col| 
                if col == 1
                    print "X "
                elsif col == 2
                    print "O "
                else 
                    print "_ "
                end
            }.join(" ")
            puts ""
        end
    end

    def check(player)
        i = 0
        ok = 0
        d1 = (0..2).collect { |i| @game.table[i][i] }
        d2 = (0..2).collect { |i| @game.table[i][3 - i - 1] }
        d3 = (0..2).collect { |i| @game.table[0][i] }
        d4 = (0..2).collect { |i| @game.table[i][0] }
        d5 = (0..2).collect { |i| @game.table[2][i] }
        d6 = (0..2).collect { |i| @game.table[i][2] }
        d7 = (0..2).collect { |i| @game.table[i][1] }
        if d3.all?(player) || d4.all?(player) || d5.all?(player) || d6.all?(player) || d7.all?(player) || d1.all?(player) || d2.all?(player)
            true
        else
            false
        end
    end

    def win(player)
        show_table
        player == 1 ? TicTacToe.playerOneWon += 1 : TicTacToe.playerTwoWon += 1
        puts "Player #{player} wins!"
        endGame
    end

    def draw
        puts "The game ended in a draw!"
        endGame
    end

    def chooseSlot(player)
        puts "--- Player #{player}'s Turn ---\nChoose an empty slot: top-right corner example: 1, 3"
        show_table
        choice = gets.chop
        choice = choice.split(", ")
        choice.map! {|x| Integer(x) - 1}
        if @game.table[choice[0]][choice[1]] == 3
            @game.table[choice[0]][choice[1]] = player
        else
            chooseSlot(player)
        end
        isWinner = check(player)
        
    end

    def beginGame
        puts @game.inspect
        @@gamesPlayed += 1
        @round = 0
        play
    end

    def endGame
        puts "Enter x to play again or q to quit."
        response = gets.chop
        if response == 'x'
            @game.table.each do |x|
                x.map! {|y| y = 3}
            end
            beginGame
        else
            nil
        end

    end

    def play
        @round += 1
        puts "### Round #{@round} ###"
        if chooseSlot(1) == true
            win(1)
        elsif @round == 5
            draw
        else
            if chooseSlot(2) == true
                win(2)
            else
                play
            end
        end
    end
    
end 

game = Games.new()