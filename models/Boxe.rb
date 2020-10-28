class Boxe
  # include modules
  include Validation
  include Db_connector

  # used to initialize class instance attributes
  attr_accessor :id
  attr_accessor :height
  attr_accessor :width
  attr_accessor :depth
  attr_accessor :type
  attr_accessor :contents
  attr_accessor :line1
  attr_accessor :line2
  attr_accessor :city
  attr_accessor :state
  attr_accessor :country
  attr_accessor :postal_code
  attr_accessor :locked

  # raise error if the json datas are not complete, then assign variables, then create boxe
  def initialize(boxe_information, response)
    return throw_unprocessable_entity(response) unless check_integrity(boxe_information)
    assign_boxe_information(boxe_information)
    create_boxe() ? throw_ok_proccess(response) : throw_internal_server_error(response)
  end

  private

  # Checking integrity of all data using the Validation module.
  def check_integrity(boxe_information)
    return false unless are_numbers?( boxe_information['id'],
                                      boxe_information['height'],
                                      boxe_information['width'],
                                      boxe_information['depth'] )

    return false unless boxe_information["origin"] != nil

    return false unless are_strings?( boxe_information['type'],
                                      boxe_information['contents'],
                                      boxe_information['origin']['line1'],
                                      boxe_information['origin']['line2'],
                                      boxe_information['origin']['city'],
                                      boxe_information['origin']['state'],
                                      boxe_information['origin']['country'],
                                      boxe_information['origin']['postal_code'] )

    return false unless is_a_boolean?(boxe_information['locked'])
    return false unless is_date_ISO3166?(boxe_information['origin']['country'])
    return false unless is_in_array?(boxe_information['type'], ['cardboard', 'wood', 'metal'])
    return true
  end

  def throw_unprocessable_entity(response)
    response.status = 422
    response['Content-Type'] = 'application/json'
    response.body = JSON.generate({ status: 422, error: 'bad format of json datas, please check api documentation'})
  end

  def throw_internal_server_error(response)
    response.status = 500
    response['Content-Type'] = 'application/json'
    response.body = JSON.generate({ status: 500, error: 'error connecting to the database'})
  end

  def throw_ok_proccess(response)
    response.status = 200
    response['Content-Type'] = 'application/json'
    response.body = JSON.generate({ status: 200, message: 'your boxe has been successfully added'})
  end

  def assign_boxe_information(boxe_information)
    self.id          = boxe_information['id']
    self.height      = boxe_information['height']
    self.width       = boxe_information['width']
    self.depth       = boxe_information['depth']
    self.type        = boxe_information['type']
    self.contents    = boxe_information['contents']
    self.line1       = boxe_information['origin']['line1']
    self.line2       = boxe_information['origin']['line2']
    self.city        = boxe_information['origin']['city']
    self.state       = boxe_information['origin']['state']
    self.country     = boxe_information['origin']['country'].upcase
    self.postal_code = boxe_information['origin']['postal_code']
    self.locked      = boxe_information['locked']
  end

  # Connection to Db using Dbconnector module and registering boxe
  def create_boxe
    return false unless db_connect
    return false unless add_box_to_db
    db_disconnect
    return true
  end

  def add_box_to_db
    begin
      @con.exec(
        "INSERT INTO boxes (id, type, locked, height, width, depth, contents)
         VALUES (#{self.id}, '#{self.type}', #{self.locked}, #{self.height}, #{self.width}, #{self.depth}, '#{self.contents}')"
      )
      @con.exec(
        "INSERT INTO origines (boxe_id, line1, line2, city, state, postal_code, country)
         VALUES (#{self.id}, '#{self.line1}', '#{self.line2}', '#{self.city}', '#{self.state}', '#{self.postal_code}', '#{self.country}')"
      )
    rescue PG::Error => e
      puts e.message
      return false
    end
    return true
  end
end
