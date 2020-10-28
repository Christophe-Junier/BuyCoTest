class Boxe
  include Validation

  def initialize(boxe_information, response)
    return throw_unprocessable_entity(response) unless check_integrity(boxe_information)
    puts 'lol'
  end

  private

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

end
