require './lib/message'
require './lib/room'
require 'faraday'
require 'json'
require 'timeout'

# HOSTNAME = 'http://chatroommmmp.herokuapp.com'
HOSTNAME = 'http://localhost:3000'


def welcome
  puts "Press 'c' to create a chatroom or 'l' to choose from a list"
  choice = gets.chomp
  case choice
  when 'c'
    create_room
  when 'l'
    show_rooms
  end
end

def command_line(room)
  text = nil
  # while room.messages.body == "[]"
  #   until text == 'e'
  #     time = 0
  #     input = nil
  #     until input == ''
  #       puts "\e[H\e[2J" # clears the screen
  #       puts "Welcome to the the Chatroom"
  #       puts "Press 'e' to exit and press enter to compose a text"  
  #       begin
  #         Timeout.timeout(1) {input = gets.chomp}
  #       rescue Timeout::Error # catches the exception from the timeout
  #       end
  #     end
  #   end
  #   print ">"
  #   text = gets.chomp
  #   unless text == 'e'
  #     post(text)
  #   end 
  # end

  text = nil
  until text == 'e'
    time = 0
    input = nil
    until input == ''
      puts "\e[H\e[2J" # clears the screen
      puts "Welcome to the the Chatroom"
      puts "Press 'e' to exit and press enter to compose a text"
      if room.messages.body != "[]"
        messages = JSON.parse(room.messages.body)
          messages.each do |message|
          puts message['message']['text']
        end
      end
      # Message.chat_feed.each do |message|
      #   puts message['message']['text']
      begin
        Timeout.timeout(1) {input = gets.chomp}
      rescue Timeout::Error # catches the exception from the timeout
      end
    end
    print ">"
    text = gets.chomp
    unless text == 'e'
      post(:text => text, :room_id => room.id)
    end 
  end
end

def post(attribuetes)
  message = Message.new(attribuetes)
  message.create
end

def create_room
  puts "Type a name for your chat room: "
  room_name = gets.chomp
  room = Room.create(:name => room_name)
  command_line(room)
end

def show_rooms
  rooms = Room.list_rooms.each_with_index {|room, i| puts "#{(i + 1)}. #{room['room']['name']}"}
  puts "Enter in the nunber of the chat room you would like to enter"
  input = gets.chomp
  room = Room.new(:name => rooms[(input.to_i - 1)]['name'], :id => (input.to_i - 1))
  command_line(room)
end

# puts "#{i + 1}: #{room.name}"

welcome