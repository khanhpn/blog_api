module Api
    module V1::CategoryApi
      class Root < Grape::API
        extend ActiveSupport::Concern
        version 'v1', using: :path

        mount Api::V1::CategoryApi::CategoryCreate
        mount Api::V1::CategoryApi::CategoryList
        mount Api::V1::CategoryApi::CategoryUpdate
        mount Api::V1::CategoryApi::CategoryDelete
      end
    end
  end
