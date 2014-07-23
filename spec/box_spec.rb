require File.join(File.expand_path(File.dirname(__FILE__)),"helper")
require "#{LIB_DIR}/box" 

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

  [:north, :south, :east, :west].each do |dir|
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
end

describe "A dots box owner" do
 
  before :each do
    @box = Dots::Box.new   
  end
  
  it "should be nil by default" do
    expect(@box.owner).to be_falsy
  end 
  
  it "should be settable via Box#owner=" do 
    @box.owner = "Gregory"
    expect(@box.owner).to eq("Gregory")
  end
end
