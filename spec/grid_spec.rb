require File.join(File.expand_path(File.dirname(__FILE__)),"helper")   
require "#{LIB_DIR}/grid"
  
describe "A dots grid" do
  
  before :each do
    @grid = Dots::Grid.new(10,10) 
  end 
  
  it "should exist" do
    expect(@grid).to be_truthy
    expect(@grid).to be_an_instance_of(Dots::Grid)
  end
end