require 'rails'
require 'yaml'
require 'mongodb_clone/engine'
require 'mongodb_clone/version'

module MongodbClone
  class MongodbReplication
    attr_accessor :id, :path

    def initialize
      @id = Time.now.utc.strftime('%Y%m%d%H%M%S')
    end

    def dump(environment = 'production', session = 'default')
      config = base_config[environment.to_s]['sessions'][session.to_s]

      params = {
        h: config['hosts'][0],
        d: config['database'],
        u: config['username'],
        p: config['password'],
        o: "/tmp/#{ config['database'] }/#{ @id }"
      }

      a = params.collect { |key, value| "-#{ key } \"#{ value.to_s.gsub("\"", "\\\"") }\"" if value }.compact.join(' ')

      command = "mongodump #{ a }"

      execute(command)

      @path = "#{ params[:o] }/#{ params[:d] }"

      self
    end

    def restore(environment = 'development', session = 'default')
      config = base_config[environment.to_s]['sessions'][session.to_s]

      params = {
        h: config['hosts'][0],
        d: config['database'],
        u: config['username'],
        p: config['password']
      }

      a = params.collect { |key, value| "-#{ key } \"#{ value.to_s.gsub("\"", "\\\"") }\"" if value }.compact.join(' ')

      command = "mongorestore --drop #{ a } #{ @path }"

      execute(command)
    end

    private

    def base_config
      YAML.load_file(Rails.root.join('config/mongoid.yml'))
    end

    def execute(command)
      puts command
      `#{ command }`
    end
  end
end
