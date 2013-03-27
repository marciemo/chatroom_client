class Room

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.create(attributes)
    response = Faraday.post do |request|
      request.url "#{HOSTNAME}/rooms/"
      request.headers['Content-Type'] = 'application/json'
      request.body = {room: attributes}.to_json
    end
    self.new(:name => attributes[:name], :id => JSON.parse(response.body)['room']['id'])
  end

  def self.list_rooms
    response = conn.get("#{HOSTNAME}/rooms/")
    body = response.body
    JSON.parse(body)
  end

  def messages
    response = Faraday.get do |request|
      request.url "#{HOSTNAME}/messages/"
      request.headers['Content-Type'] = 'application/json'
      request.body = {room_id: self.id}.to_json
    end
  end

  

  private

  def conn
    Faraday.new(HOSTNAME)
  end

  def self.conn
    Faraday.new(HOSTNAME)
  end

end

#<Faraday::Response:0x007fa59e0d8180 @env={:method=>:post, :body=>"{\"room\":{\"created_at\":\"2013-03-27T22:02:41Z\",\"id\":8,\"name\":\"green\",\"updated_at\":\"2013-03-27T22:02:41Z\"}}", :url=>#<URI::HTTP:0x007fa59d6c8398 URL:http://localhost:3000/rooms/>, :request_headers=>{"User-Agent"=>"Faraday v0.8.7", "Content-Type"=>"application/json"}, :parallel_manager=>nil, :request=>{:proxy=>nil}, :ssl=>{}, :status=>201, :response_headers=>{"content-type"=>"application/json; charset=utf-8", "etag"=>"\"90feb6de566d8005e6118015914ac38c\"", "cache-control"=>"max-age=0, private, must-revalidate", "x-request-id"=>"88b0950faf22ab8212e992f940a4cea6", "x-runtime"=>"0.003582", "server"=>"WEBrick/1.3.1 (Ruby/1.9.3/2013-02-06)", "date"=>"Wed, 27 Mar 2013 22:02:41 GMT", "content-length"=>"104", "connection"=>"Keep-Alive"}, :response=>#<Faraday::Response:0x007fa59e0d8180 ...>}, @on_complete_callbacks=[]>
