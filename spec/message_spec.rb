require 'spec_helper'


describe Message do

  let (:text) {'test'}
  let (:message) {Message.new(text)}

  context '#initialize' do 
    it 'creates an instance of Message with text as an argument' do 
      message.should be_an_instance_of Message
    end
  end

  context 'readers' do
    it 'returns the text with #text' do
      message.text.should eq text
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
    it 'GETs a list of up to 20 current chat posts' do
      stub = stub_request(:get, "#{HOSTNAME}/messages/")
      Message.chat_feed
      stub.should have_been_requested
    end
  end
end