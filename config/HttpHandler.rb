class HttpHandler < WEBrick::HTTPServlet::AbstractServlet

  def do_GET(request, response)
    process_result = throw_not_found()
    response.status = process_result[:status]
    response['Content-Type'] = process_result[:content_type]
    response.body = process_result[:body]
  end

  def throw_not_found
    {
      status: 404,
      content_type: "text/html",
      body: File.read("views/errors/404.html.erb")
    }
  end

end
