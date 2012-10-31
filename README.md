# MongodbClone

Dump and restore databases easily.

[Backup and Restoration Strategies & MongoDB Manual](http://docs.mongodb.org/manual/administration/backups/#database-dumps)

## Installation

Add this line to your application's Gemfile:

    gem 'mongodb_clone'

And then execute:

    $ bundle

## Usage

Use a rake task to **dump** production database and **restore** locally.


    $ rake db:copy:production:to_local

or create your tasks:

``` ruby
# Dump environment "staging", session "default" and restore in "development" environment, session "backup"
MongodbClone::MongodbReplication.new.dump('staging').restore('development', 'backup')
```

Use `config/mongoid.yml` to configure the environments:

``` yml
development:
  sessions:
    default:
      database: mongodb_clone_development
      hosts:
        - localhost:27017
    backup:
      database: mongodb_clone_development
      hosts:
        - localhost:27017

staging:
  sessions:
    default:
      database: mongodb_clone_staging
      username: mongodb_clone
      password: 12345678
      hosts:
        - mongodb_clone_staging.example.com:27017

production:
  sessions:
    default:
      database: mongodb_clone_production
      username: mongodb_clone
      password: 12345678
      hosts:
        - mongodb_clone.example.com:27017
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License. Copyright 2012 Tiago Rafael Godinho
