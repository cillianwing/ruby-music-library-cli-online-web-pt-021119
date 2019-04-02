require 'pry'

class MusicLibraryController
  attr_accessor :music

  def initialize(path='./db/mp3s')
    @music = MusicImporter.new(path).import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      
      input = gets.strip
    end
  end

  def list_songs
    Song.all.sort_by(&:name).each_with_index do |x, index|
      puts "#{index+1}. #{x.artist.name} - #{x.name} - #{x.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by(&:name).each_with_index do |x, index|
      puts "#{index+1}. #{x.name}"
    end
  end

  def list_genres
    Genre.all.sort_by(&:name).each_with_index do |x, index|
      puts "#{index+1}. #{x.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    Song.all.each_with_index do |x, index|
      puts "#{index+1}. #{x.name} - #{x.genre.name}" if x.name == input 
    end
    #binding.pry
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
  end

  def play_song
    puts "Which song number would you like to play?"
    song_num = gets.chomp
    #binding.pry
    if (1..list_songs.length).include?(song_num)
      #play song
    end
  end

end
