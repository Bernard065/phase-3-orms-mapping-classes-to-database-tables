class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  #class method on the current class
  def self.create_table

    #sql variable set to a multi-line string that contain SQL statement(heredoc syntax=allows you to define a multi-line string in a more readable way) #SQL at the end is a label to mark the end of the string
    # DB[:conn].execute(sql) executes the SQL statements stored in the sql variable using execute method on the :conn key of the DB hash
    #from the DB = { conn: SQLite3::Database.new('db/music.db') } constant
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL 
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO songs (name, album) 
      VALUES (?, ?)
    SQL
    #inserting a song
    DB[:conn].execute(sql, self.name, self.album)

    #get the song ID from the database and save it to the Ruby instance
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    #return the ruby instance
    self
  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end

end