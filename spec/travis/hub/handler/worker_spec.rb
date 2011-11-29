require 'spec_helper'

describe Travis::Hub::Handler::Worker do
  let(:handler) { @handler ||= Travis::Hub::Handler::Worker.new(:event, Hashr.new(payload)) }
  let(:worker)  { stub('worker', :update_attributes! => nil) }
  let(:payload) { { 'travis-test-1' => { 'name' => 'travis-test-1', 'host' => 'host', 'state' => 'ready' } } }

  before :each do
    handler.stubs(:worker_by).returns(worker)
  end

  describe 'handle' do
    it 'updates the worker states and last_seen_at attributes' do
      worker.expects(:ping!)
      worker.expects(:set_state).with('ready')
      handler.event = :'worker:status'
      handler.handle
    end
  end

  # TODO make the db available here
  #
  # describe 'workers' do
  #   it 'returns workers grouped by their full_name' do
  #     worker = Worker.create(:name => 'worker-1', :host => 'host')
  #     handler.send(:workers)['host:worker-1'].should == worker
  #   end
  # end
  #
  # describe 'worker' do
  #   it 'returns an existing worker instance'
  #   it 'returns a new worker instance'
  # end
end


