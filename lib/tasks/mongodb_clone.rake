namespace :db do
  namespace :copy do
    namespace :production do
      desc 'Copy production database'
      task to_local: ['db:drop'] do
        MongodbClone::MongodbReplication.new.dump.restore
      end
    end
  end
end
