require 'socket'

server = TCPServer.new(2345)
client = server.accept
@client = client

class NoteList
  attr_reader :note, :notes

  def initialize
    @notes = []
  end

  def store_note(note)
    notes << note
  end

  def view
    notes
  end
end

class Note
  attr_reader :my_note

  def initialize(my_note)
    @my_note = my_note
  end
end

@note_list = NoteList.new

client.puts 'Please enter your name...'
@name = client.gets.chomp
client.puts "Welcome to my server, #{@name}."
client.puts 'Please enter your note...'

loop {
  my_note = client.gets.chomp
  break if my_note =='exit'
  new_note = Note.new(my_note)
  @note_list.store_note(new_note)
  client.puts 'Thanks, your note has been saved.'
  client.puts 'Please enter another note... (exit to finish)'
}

def show_notes
  @note_list.notes.each { |note| @client.puts note.my_note }
end

client.puts 'Here are your notes:'
show_notes

client.close
