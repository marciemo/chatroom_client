class Message

  attr_reader :text

  def initialize(text)
    @text = text
    @params = {:text => text}
  end

  def create
    response = Faraday.post do |request|
  
      request.url 'http://localhost:3000/messages/'
    
      request.headers['Content-Type'] = 'application/json'
    
      request.body = {message: {text: self.text}}.to_json
    end
  end

  def self.chat_feed
    response = conn.get("#{HOSTNAME}/messages/")
    chat = JSON.parse(response.body)
  end

  private

  def conn
    Faraday.new(HOSTNAME)
  end

  def self.conn
    Faraday.new(HOSTNAME)
  end
end

