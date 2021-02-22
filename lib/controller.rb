module Clock

  class Controller
    def initialize(collection, factory)
      @factory = factory
      @collection = collection
    end
    def record(clock)
      @collection.create(clock)
    end
    def find(name:)
      @collection.find_by_name(name).tap do |result|
        if result.object == nil then result.object = @factory.current(name) end
      end
    end
  end
end
