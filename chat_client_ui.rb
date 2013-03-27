require './lib/message'
require 'faraday'
require 'json'
require 'timeout'

HOSTNAME = 'http://localhost:3000'


def welcome
  puts "Welcome to the the Chatroom"
  command_line
  # test_post
end

# def command_line
#   command = ''
#   until command == 'exit'
#     print '> '
#     input = gets.chomp
#     word_array = input.split(' ')
#     command = word_array.shift
#     words = word_array.join(' ')
#     case command
#     when 'p'
#       post(words)
#     when 'exit'
#       puts "Exiting."
#     end
#   end
# end

# def test_post 
#   puts "enter something"
#   message = Message.new(gets.chomp)
#   message.create
# end

def command_line
  puts "Press 'e' to exit and press enter to compose a text"
  text = nil
  until text == 'e'
    time = 0
    input = nil
    until input == ''
      puts "\e[H\e[2J" # clears the screen
      Message.chat_feed.each do |message|
        puts message['message']['text']
      end
      begin
        Timeout.timeout(1) {input = gets.chomp}
      rescue Timeout::Error # catches the exception from the timeout
      end
    end
    print ">"
    text = gets.chomp
    post(text)
  end
end

def post(words)
  message = Message.new(words)
  message.create
end

welcome