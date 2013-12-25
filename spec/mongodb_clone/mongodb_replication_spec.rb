require 'spec_helper'

describe MongodbClone::MongodbReplication do
  before do
    file = File.join(File.dirname(__FILE__), '../', 'support', 'mongoid.yml')
    Rails.stub_chain(:root, :join).and_return(file)
  end

  subject { MongodbClone::MongodbReplication.new.as_null_object }

  describe '#dump' do
    it 'returns the object to create a chain of methods' do
      subject.stub(:execute)
      expect(subject.dump).to be_an_instance_of(described_class)
    end

    it 'should dump database' do
      subject.id = '201210231843100200'
      subject.should_receive(:execute).with('mongodump -h "mongodb_clone.example.com:27017" -d "mongodb_clone_production" -u "mongodb_clone" -p "12345678" -o "/tmp/mongodb_clone_production/201210231843100200"')

      subject.dump
    end

    context 'when dump the development database' do
      it 'should dump the selected database' do
        subject.id = '201210231843100200'
        subject.should_receive(:execute).with('mongodump -h "localhost:27017" -d "mongodb_clone_development" -o "/tmp/mongodb_clone_development/201210231843100200"')

        subject.dump(:development)
      end
    end
  end

  describe '#restore' do
    it 'should restore database' do
      subject.id = '201210231843100200'
      subject.path = '/tmp/mongodb_clone_production/201210231843100200/mongodb_clone_production'
      subject.should_receive(:execute).with('mongorestore --drop -h "localhost:27017" -d "mongodb_clone_development" /tmp/mongodb_clone_production/201210231843100200/mongodb_clone_production')

      subject.restore
    end
  end
end
