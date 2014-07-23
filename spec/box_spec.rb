require File.join(File.expand_path(File.dirname(__FILE__)),"helper")
require "#{LIB_DIR}/box" 

def directions 
  [:north, :south, :east, :west]
end

describe "A dots box" do

  before :each do
    @box = Dots::Box.new
  end

  it "should exist" do
    expect(@box).to be_truthy
    expect(@box).to be_an_instance_of(Dots::Box)
  end

  it "should have 4 edges" do
    expect(@box.edges.size).to eq(4)
  end

  directions.each do |dir|
    it "should have an #{dir} edge" do
      expect(@box.edges[dir]).to be_truthy
    end
    
    it "#{dir} edge should be :not_drawn by default" do
      expect(@box.edges[dir]).to eq(:not_drawn)  
    end   
    
    it "#{dir} edge should be :drawn when draw_edge(#{dir.inspect}) is called" do
      @box.draw_edge(dir)
      expect(@box.edges[dir]).to eq(:drawn)
    end
  end

  it "should return nil for owner() by default" do
    expect(@box.owner).to be_falsy
  end
end

describe "An incomplete dots box" do
 
  before :each do
    @box = Dots::Box.new
  end
  
  it "should return false for completed?" do
    expect(@box.completed?).to be false
  end
  
  it "should not allow an owner to be set" do
    expect { @box.owner = "Gregory" }.to raise_error(Dots::BoxIncompleteError)
  end
end

describe "A completed dots box" do
  
  before :each do
    @box = Dots::Box.new
    directions.each { |dir| @box.draw_edge(dir) }
  end
  
  it "should return true for completed?" do
    expect(@box.completed?).to be true
  end
  
  it "should allow an owner to be set" do
    @box.owner = "Gregory"
    expect(@box.owner).to eq("Gregory")
  end
end