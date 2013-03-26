HOSTNAME = 'http://localhost:3000'


def welcome
  puts "Welcome to the the Chatroom"
  puts "Type 'v' to view current chats" #needs work
  puts "Type 'p' followed by your message to post" #needs work
  command_line
end

def command_line
  command = ''
  until command == 'exit'
    print '> '
    input = gets.chomp
    word_array = input.split(' ')
    command = word_array.shift
    words = word_array.join(' ')
    case command
    when 'p'
      post(words)
    when 'exit'
      puts "Exiting."
    end
  end
end

def post(words)
  message = Message.new(words)
  message.create
end

welcome