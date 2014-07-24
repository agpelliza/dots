module Dots
  class Interface
     require "highline/import"
     
     def get_players
       players = []
       loop { players << ask("Player: ") }
     rescue EOFError
        say "\n\nPlaying: #{players.join(',')}"
        return players
     end
   
     def get_grid_size
       rows    = ask("Rows: ",Integer) { |q| q.validate = /\A\d+\Z/ }
       columns = ask("Columns: ",Integer) { |q| q.validate = /\A\d+\Z/ }
       [rows,columns]
     end
     
     def update_display(game)
       display_grid(game)
       say "\nCurrent Player: #{game.current_player}"
       say "Scores: (#{score_board(game)})"
     end
     
     def get_move
       to_coords = lambda { |s| s.split(",").map { |e| e.to_i } }
       valid_coords = /\A\s*\d+\s*,\d+\s*\Z/
       from = ask("Draw from (x,y): ", to_coords ) do |q|
         q.validate = valid_coords
       end
       to = ask("Draw to (x,y): ", to_coords) do |q|
         q.validate = valid_coords
       end
       [from,to]
     end
     
     def score_board(game)
       game.players.inject("") do |str,player|
         str + " " + player + ": #{game.score(player)}"
       end
     end
     
     def display_grid(game)
       puts((0..game.grid.cols).to_a.join("   "))
       (game.grid.rows - 1).downto(0) do |y|
         row = (0..game.grid.cols-1).map { |x| game.grid.box_at(x,y) }
         puts row.map { |r| r.edges[:north] == :drawn ? "+===" : "+ - " }.join + "+ #{y + 1}"
         print row.map { |r|
           w = r.completed? ? r.owner[0].chr : " "
           r.edges[:east] == :drawn ?  "| #{w} " : "-   "
         }.join
         puts row[-1].edges[:west] == :drawn ? "|" : "-"
         if y == 0
           puts row.map { |r| r.edges[:south] == :drawn ? "+===" : "+ - " }.join + "+ 0"
         end
       end
     end
  end
end