require 'sequel'

class Database
  def self.all_clocks
    @all_clocks ||= []
  end
  def self.all_clocks=(clocks)
    @all_clocks = clocks
  end
end
