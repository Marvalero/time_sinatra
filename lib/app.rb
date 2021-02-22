require 'sinatra'
require_relative 'api'
require_relative 'controller'
require_relative 'collection'
require_relative 'entity'
require_relative 'database'

module Clock
  class Box
    def api
      Api.new(controller, factory)
    end
    def controller
      Controller.new(collection, factory)
    end
    def collection
      Collection.new(database, factory)
    end
    def database
      Database
    end
    def factory
      Entity
    end
  end
end
