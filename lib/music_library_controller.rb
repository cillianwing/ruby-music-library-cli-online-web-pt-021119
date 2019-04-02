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
      list_songs if input == "list songs"
      list_artists if input == "list artists"
      list_genres if input == "list genres"
      list_songs_by_artist if input == "list artist"
      list_songs_by_genre if input == "list genre"
      play_song if input == "play song"
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
    if artist = Artist.find_by_name(input)
      artist.songs.sort_by(&:name).each_with_index do |x, index|
        puts "#{index+1}. #{x.name} - #{x.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
      genre.songs.sort_by(&:name).each_with_index do |x, index|
        puts "#{index+1}. #{x.artist.name} - #{x.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    #binding.pry
    if (1..Song.all.length).include?(input)
      song = Song.all.sort_by(&:name)[input - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end

end
