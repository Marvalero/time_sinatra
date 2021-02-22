require 'sequel'

module Clock
  class RecordResult
    attr_reader :success, :id, :error_message
    attr_accessor :object
    def initialize(success:, id:, error_message:, object:)
      @success = success
      @id = id
      @error_message = error_message
      @object = object
    end
  end
  class Database
    def self.all_clocks
      @all_clocks ||= {}
    end
    def self.store_clock(clock)
      all_clocks[clock[:name]] = clock
      RecordResult.new(success: true, id: 2, error_message: nil, object: clock)
    end
    def self.find_by_name(name)
      RecordResult.new(success: true, id: 2, error_message: nil, object: all_clocks[name])
    end
  end
end
