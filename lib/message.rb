class Message

  attr_reader :text, :room_id

  def initialize(attributes)
    @text = attributes[:text]
    @room_id = attributes[:room_id]
    @params = attributes
  end

  def create
    response = Faraday.post do |request|
      request.url "#{HOSTNAME}/messages/"
      request.headers['Content-Type'] = 'application/json'
      request.body = {message: {text: self.text, room_id: self.room_id}}.to_json
    end
  end

  def self.chat_feed
    response = conn.get("#{HOSTNAME}/messages/")
    response.body
    JSON.parse(response.body)
  end

  private

  def conn
    Faraday.new(HOSTNAME)
  end

  def self.conn
    Faraday.new(HOSTNAME)
  end
end

