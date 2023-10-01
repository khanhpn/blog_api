module Api
    module V1::Authorization
      class Root < Grape::API
        extend ActiveSupport::Concern
        version 'v1', using: :path

        mount Api::V1::Authorization::Register
        mount Api::V1::Authorization::Login
      end
    end
  end
