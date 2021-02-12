module Clock
  Clock = Struct.new(:time)
  RecordResult = Struct.new(:success?, :id, :error_message, :object)

  class ClockController
    def record(config)
      clock = Clock.new("a")
      RecordResult.new(true, 1, nil, clock)
    end
    def find(name:)
    end
  end
end
