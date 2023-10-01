module Api
    module V1::ArticleApi
      class Root < Grape::API
        extend ActiveSupport::Concern
        version 'v1', using: :path

        mount Api::V1::ArticleApi::ArticleCreate
        mount Api::V1::ArticleApi::ArticleDelete
        mount Api::V1::ArticleApi::ArticleUpdate
        mount Api::V1::ArticleApi::ArticleList
      end
    end
  end
