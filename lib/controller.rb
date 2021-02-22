module Clock
  RecordResult = Struct.new(:success?, :id, :error_message, :object)

  class Controller
    def initialize(collection, factory)
      @factory = factory
      @collection = collection
    end
    def record(params)
      @collection.create(params)
    end
    def find(name:)
      @collection.find_by_name(name).tap do |result|
        if result.object == nil then result.object = @factory.current(name) end
      end
    end
  end
end
