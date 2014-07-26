class Database
  def self.db
    @db = Sequel.sqlite
  end
end