class Volume < Boxe
  # include modules
  include Validation
  include Db_connector

  # used to initialize class instance attributes
  attr_accessor :id
  attr_accessor :volume

  # raise error if the json datas are not complete, then assign variables, then create volume
  def initialize(boxe_information, response)
    return throw_unprocessable_entity(response) unless check_integrity(boxe_information)
    assign_volume_information(boxe_information)
    create_volume() ? throw_ok_proccess(response) : throw_internal_server_error(response)
  end

  private

  def assign_volume_information(boxe_information)
    self.id          = boxe_information['id']
    self.volume      = boxe_information['height'] * boxe_information['width'] * boxe_information['depth']
  end

  # Connection to Db using Dbconnector module and registering boxe
  def create_volume
    return false unless db_connect
    return false unless add_volume_to_db
    db_disconnect
    return true
  end

  def add_volume_to_db
    begin
      @con.exec(
        "INSERT INTO volumes (boxe_id, volume)
         VALUES (#{self.id}, #{self.volume})"
      )
    rescue PG::Error => e
      puts e.message
      return false
    end
    return true
  end
end
