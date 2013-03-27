require 'spec_helper'


describe Message do

  let (:valid_attributes) {{:text =>'test', :room_id => '1'}}
  let (:message) {Message.new(valid_attributes)}

  context '#initialize' do 
    it 'creates an instance of Message with text as an argument' do 
      message.should be_an_instance_of Message
    end
  end

  context 'readers' do
    it 'returns the text with #text' do
      message.text.should eq valid_attributes[:text]
    end

    it 'returns the room_id with #room_id' do
      message.room_id.should eq valid_attributes[:room_id]
    end
  end

  context '#create' do
    it 'POSTs a new message' do
      stub = stub_request(:post, "#{HOSTNAME}/messages/")
      message.create
      stub.should have_been_requested
    end
  end

  context '#chat_feed' do
    it 'GETs a list of current chat posts' do
      stub = stub_request(:get, "#{HOSTNAME}/messages/").
        to_return(:body => "[{\"message\":{\"created_at\":\"2013-03-26T23:02:11Z\",\"id\":1,\"text\":\"test\",\"updated_at\":\"2013-03-26T23:02:11Z\"}}]")
      Message.chat_feed
      stub.should have_been_requested
    end
  end
end