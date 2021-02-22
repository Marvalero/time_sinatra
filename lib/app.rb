require 'sinatra'
require_relative 'config/sequel'
require_relative 'api'
require_relative 'controller'
require_relative 'collection'
require_relative 'entity'

module Clock
  class Box
    def api
      Api.new(controller)
    end
    def controller
      Controller.new(collection, factory)
    end
    def collection
      Collection.new()
    end
    def factory
      Entity
    end
  end
end
