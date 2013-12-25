require 'yaml'

module MongodbClone
  class MongodbReplication
    attr_accessor :id, :path

    def initialize
      @id = Time.now.utc.strftime('%Y%m%d%H%M%S')
    end

    def dump(environment = 'production', session = 'default')
      config = get_config(environment, session)

      params = default_params(config).merge({ o: "/tmp/#{ config['database'] }/#{ @id }" })

      a = hash_to_inline_params(params)

      command = "mongodump #{ a }"

      execute(command)

      @path = "#{ params[:o] }/#{ params[:d] }"

      self
    end

    def restore(environment = 'development', session = 'default')
      config = get_config(environment, session)

      a = hash_to_inline_params(default_params(config))

      command = "mongorestore --drop #{ a } #{ @path }"

      execute(command)
    end

    private

    def default_params(config)
      {
        h: config['hosts'][0],
        d: config['database'],
        u: config['username'],
        p: config['password']
      }
    end

    def get_config(environment, session)
      base_config[environment.to_s]['sessions'][session.to_s]
    end

    def hash_to_inline_params(params)
      params.collect { |key, value| "-#{ key } \"#{ value.to_s.gsub("\"", "\\\"") }\"" if value }.compact.join(' ')
    end

    def base_config
      YAML.load_file(Rails.root.join('config/mongoid.yml'))
    end

    def execute(command)
      puts command
      `#{ command }`
    end
  end
end
