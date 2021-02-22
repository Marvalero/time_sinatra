module Clock
  class Collection
    def initialize(database, factory)
      @database = database
      @factory = factory
    end

    def create(clock)
      database.store_clock(map_clock_to_hash(clock))
    end

    def find_by_name(name)
      response = database.find_by_name(name)
      map_hash_to_clock(response)
    end

    private
    attr_reader :database, :factory

    def map_clock_to_hash(clock)
      { name: clock.name, time: clock.time }
    end

    def map_hash_to_clock(response)
      response.tap do |r|
        r.object = factory.new(**r.object)
      end
    end
  end
end
