#require the bundler gem in the application. The bundler manages gem dependencies for a projects
'require bundler'
Bundler.require

#loads the song.rb file
require_relative '../lib/song.rb'

#creates a constant DB which is a signed a hash with a single key-value pair and initialized with the file path 'db/music.db'
DB = { conn: SQLite3::Database.new('db/music.db') }
