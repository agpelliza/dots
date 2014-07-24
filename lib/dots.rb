LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)))

%w[box game grid interface].each do |lib|
  require LIB_DIR + "/dots/#{lib}"
end
