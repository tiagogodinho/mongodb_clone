require 'rails/engine'

module MongodbClone
  class Engine < ::Rails::Engine
    isolate_namespace MongodbClone
  end
end
