require File.join(File.expand_path(File.dirname(__FILE__)),"helper")

module InitialGameStateMocks

  def mock_player_selection
    expect(@game.interface).to receive(:get_players).and_return(["Gregory","Joe"])
  end
  
  def mock_prompt_for_grid_size
    grid = double("grid")  
    expect(@game.interface).to receive(:get_grid_size).and_return([8,10])
    expect(Dots::Grid).to receive(:new).with(8,10).and_return(grid)
  end
  
  def mock_initial_game_state
    @game.interface = double("UI")
    mock_player_selection
    mock_prompt_for_grid_size
  end
end

describe "A newly started game" do

  include InitialGameStateMocks
  
  before :each do
    @game = Dots::Game.new
    mock_initial_game_state
    @game.start
  end
  
  it "should have an array of players" do 
    expect(@game.players).to eq(["Gregory","Joe"])
  end
  
  it "should set the first player entered via the UI to the current_player" do
    expect(@game.current_player).to eq("Gregory")
  end
  
  it "should populate a grid from UI input" do
    expect(@game.grid).to be_truthy
  end
end

describe "A Game in progress with two players" do
 
 include InitialGameStateMocks
 
 before :each do
   @game = Dots::Game.new
    mock_initial_game_state
   @game.start
 end
 
 it "should alternate players when a box is not completed" do
   expect(@game.current_player).to eq("Gregory")
   stub_move([[0,0],[0,1]],0)
   expect(@game.current_player).to eq("Joe")
   stub_move([[0,1],[1,1]],0) 
   expect(@game.current_player).to eq("Gregory")
 end
 
 it "should not change players if 1 box is completed" do
   expect(@game.current_player).to eq("Gregory")
   stub_move([[0,0],[0,1]],1)
   expect(@game.current_player).to eq("Gregory")
 end
 
 it "should not change players if 2 boxes are completed" do
   expect(@game.current_player).to eq("Gregory")
   stub_move([[0,0],[0,1]],2)
   expect(@game.current_player).to eq("Gregory")
 end
 
 def stub_move(edge, boxes_completed = 0)
   @game.interface = double("UI")
   box_set = double("box set")
   if boxes_completed.zero?
     expect(box_set).to receive(:empty?).and_return(true)
   else
     expect(box_set).to receive(:empty?).and_return(false)
     expect(box_set).to receive(:size).and_return(boxes_completed)
   end
   expect(@game.interface).to receive(:get_move).and_return(edge)
   expect(@game.grid).to receive(:connect).with(*edge).and_return(box_set)
   @game.move  
 end
end