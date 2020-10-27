class HttpController < WEBrick::HTTPServlet::AbstractServlet

  def do_GET(request, response)
    throw_not_found(response)
  end

  def do_POST(request, response)
    if request.content_type == 'application/json' && valid_json?(request.body)
      Boxe.new(@boxe_information, response)
    else
      throw_unprocessable_entity(response)
    end
  end

  private

  def throw_not_found(response)
    response.status = 404
    response['Content-Type'] = 'text/html'
    response.body = File.read("views/errors/404.html.erb")
  end

  def throw_unprocessable_entity(response)
    response.status = 422
    response['Content-Type'] = 'application/json'
    response.body = JSON.generate({ status: 422, error: 'Your datas are unprocessable'})
  end

  def valid_json?(request_body)
    begin
      @boxe_information = JSON.parse(request_body)
    rescue JSON::ParserError
      return false
    end
  end
end
