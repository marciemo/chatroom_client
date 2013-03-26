class Message

  attr_reader :text

  def initialize(text)
    @text = text
    @params = {:text => text}
  end

  def create
    conn.post("#{HOSTNAME}/messages/",@params)
  end

  def self.chat_feed
    conn.get("#{HOSTNAME}/messages/")
  end

  private

  def conn
    Faraday.new(HOSTNAME)
  end

  def self.conn
    Faraday.new(HOSTNAME)
  end
end

