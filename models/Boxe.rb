class Boxe
  require_relative '../modules/Validation'

  def initialize(boxe_information, response)
    check_integrity(boxe_information, response)
    puts 'lol'
  end

  private

  def check_integrity(boxe_information, response)
    throw_unprocessable_entity(response) unless are_numbers?( boxe_information['id'],
                                                              boxe_information['height'],
                                                              boxe_information['width'],
                                                              boxe_information['depth'] )

    throw_unprocessable_entity(response) unless are_strings?( boxe_information['type'],
                                                              boxe_information['contents'],
                                                              boxe_information['origin']['line1'],
                                                              boxe_information['origin']['line2'],
                                                              boxe_information['origin']['city'],
                                                              boxe_information['origin']['state'],
                                                              boxe_information['origin']['country'],
                                                              boxe_information['origin']['postal_code'] )

    throw_unprocessable_entity(response) unless is_a_boolean?(boxe_information['locked'])
    throw_unprocessable_entity(response) unless is_date_ISO3166?(boxe_information['country'])
    throw_unprocessable_entity(response) unless is_in_array?(boxe_information['type'], ['cardboard', 'wood', 'metal'])
  end

  def throw_unprocessable_entity(response)
    response.status = 422
    response['Content-Type'] = 'application/json'
    response.body = JSON.generate({ status: 422, error: 'bad format of json datas, please check api documentation'})
    return response
  end

end
