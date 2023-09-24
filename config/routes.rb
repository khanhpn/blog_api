Rails.application.routes.draw do
  mount Api::Root => '/'
  unless Rails.env.test?
    mount GrapeSwaggerRails::Engine, at: '/docs'
  end
end
