module Clock
  class Entity
    attr_reader :time, :name
    def initialize(time:, name:)
      @time = time
      @name = name
    end

    def self.current(name)
      new(time: Time.now, name: name)
    end
  end
end
