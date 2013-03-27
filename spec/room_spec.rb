require 'spec_helper'

describe Room do 

  let (:name) {{:name => 'green'}}
  let (:room) {Room.new(name)}

  it 'initializes with a hash of the name' do
    room.should be_an_instance_of Room
  end

  context 'readers' do
    it 'returns the name with #name' do
      room.name.should eq name[:name]
    end
  end

  context '#create' do
    it 'POSTs a new room' do
      # WebMock.allow_net_connect!
      stub = stub_request(:post, "#{HOSTNAME}/rooms/").
        to_return(:body => "{\"room\":{\"created_at\":\"2013-03-27T22:03:38Z\",\"id\":9,\"name\":\"green\",\"updated_at\":\"2013-03-27T22:03:38Z\"}}")
      Room.create(name)
      stub.should have_been_requested
    end
  end

  context '#list_rooms' do
    it 'GETs a list of the chatrooms' do
      # WebMock.allow_net_connect!
      stub = stub_request(:get, "#{HOSTNAME}/rooms/").
        to_return(:body => "[{\"room\":{\"created_at\":\"2013-03-26T23:02:11Z\",\"id\":1,\"name\":\"test\",\"updated_at\":\"2013-03-26T23:02:11Z\"}}]")
      Room.list_rooms
      stub.should have_been_requested
    end
  end

  context '#messages' do
    it 'returns an array of messages' do

    end
  end
end