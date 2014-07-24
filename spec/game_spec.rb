require File.join(File.expand_path(File.dirname(__FILE__)),"helper")

describe "A newly started game" do
  
  before :each do
    @game = Dots::Game.new
    @game.interface = double("UI")
    mock_player_selection
    mock_prompt_for_grid_size
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
  
  def mock_player_selection
    expect(@game.interface).to receive(:get_players).and_return(["Gregory","Joe"])
  end
  
  def mock_prompt_for_grid_size
    grid = double("grid")  
    expect(@game.interface).to receive(:get_grid_size).and_return([8,10])
    expect(Dots::Grid).to receive(:new).with(8,10).and_return(grid)
  end
end