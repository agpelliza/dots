require "rspec" 

LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)), *%w[.. lib dots])
require "#{LIB_DIR}/grid"
require "#{LIB_DIR}/box"   
require "#{LIB_DIR}/game"
