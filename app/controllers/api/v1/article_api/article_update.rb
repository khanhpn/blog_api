module Api
  module V1
    module ArticleApi
      class ArticleUpdate < Grape::API
        namespace :article do
          desc 'Article update'
          params do
            requires :id, type: Integer, desc: 'Type id'
            optional :name, type: String, desc: 'Type name'
            optional :content, type: String, desc: 'Type content'
            optional :category_id, type: Integer, desc: 'Type category id'
            optional :isShow, type: Boolean, desc: 'Type available'
          end
          patch ':id' do
            user = current_user
            article = user.articles.find(params[:id])
            if article.present?
              article.update(params)
              status 200
              article
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
