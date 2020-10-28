module Db_connector
  require 'pg'

  def db_connect
    begin
      @con = PG.connect("db_link", 5432, '', '', "db_buyco", "admin", "admin")
    rescue PG::Error => e
      puts e.message
      return false
    end
  end

  def db_disconnect
    @con.close if @con
  end

end
