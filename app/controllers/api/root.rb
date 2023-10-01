require 'grape'
require 'grape-swagger'

module Api
  class Root < Grape::API
    prefix :api
	  format :json

	  mount Api::V1::Root
	  add_swagger_documentation
  end
end
