module Api
  module V1
    module ArticleApi
      class ArticleList < Grape::API
        namespace :article do
          desc 'list of category'
          get do
            articles = Article.all
            status 200
            articles
          end
        end
      end
    end
  end
end
