module Api
  module V1
    module ArticleApi
      class ArticleDelete < Grape::API
        namespace :article do
          desc 'Article delete'
          params do
            requires :id, type: Integer, desc: 'Type id'
          end
          delete ':id' do
            user = current_user
            article = user.articles.find(params[:id])
            if article.present?
              article.destroy
              status 200
              {message: "Delete sucessful"}
            end
          rescue => e
            status 500
            e.message
          end
        end
      end
    end
  end
end
