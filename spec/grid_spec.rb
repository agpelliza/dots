require File.join(File.expand_path(File.dirname(__FILE__)),"helper")   
require "set"
  
describe "A dots grid" do
  
  before :each do
    @grid = Dots::Grid.new(10,10) 
  end 
  
  it "should exist" do
    expect(@grid).to be_truthy
    expect(@grid).to be_an_instance_of(Dots::Grid)
  end

  it "should have one box for each edge on left side" do
    10.times do |y|
      expect(@grid[[0,y],[0,y+1]].length).to eq(1)
    end
  end
  
  it "should have one box for each edge on right side" do
    10.times do |y|
      expect(@grid[[10,y],[10,y+1]].length).to eq(1)
    end
  end
  
  it "should have one box for each edge on top side" do
    10.times do |x|
      expect(@grid[[x,10],[x+1,10]].length).to eq(1)
    end
  end
  
  it "should have one box for each edge on bottom side" do
    10.times do |x|
      expect(@grid[[x,0],[x+1,0]].length).to eq(1)
    end
  end
  
  it "should have two boxes for all inner edges" do
    (1..8).each do |x|
      (1..8).each do |y|
        expect(@grid[[x,y],[x+1,y]].length).to eq(2)
        expect(@grid[[x,y],[x,y+1]].length).to eq(2)
      end
    end
  end

  it "should allow connecting adjacent dots" do
    @grid.connect([0,0],[0,1])
    expect(@grid.box_at(0,0).edges[:east]).to eq(:drawn)
  end
  
  it "should throw an error when connecting non-adjacent dots" do
    expect { @grid.connect([0,0],[0,5]) }.to raise_error(Dots::InvalidEdgeError)
  end
end

describe "A drawn on dots grid" do
 
  before :each do
    @grid = Dots::Grid.new(10,10)
    @grid.connect [0,0], [0,1]
    @grid.connect [0,1], [1,1]
    @grid.connect [1,0], [0,0]
  end
  
  it "should notify Game object when box is completed on a connect" do
    expect(Dots::Game).to receive(:filled_boxes).with(Set[@grid.box_at(0,0)]).once
    @grid.connect [1,1], [1,0]
  end
  
  it "should notify Game object when two boxes are completed on a connect" do
    @grid.connect [1,0], [2,0]
    @grid.connect [2,0], [2,1]
    @grid.connect [2,1], [1,1]
    
    expect(Dots::Game).to receive(:filled_boxes).
               with(Set[@grid.box_at(0,0),@grid.box_at(1,0)]).once
               
    @grid.connect [1,1], [1,0]
  end
end