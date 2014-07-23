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
end
