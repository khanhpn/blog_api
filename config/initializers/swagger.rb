unless Rails.env.test?
  GrapeSwaggerRails.options.url = '/api/swagger_doc'
  GrapeSwaggerRails.options.before_action do
    GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  end
end
