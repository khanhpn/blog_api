module Api
    module V1
      module ArticleApi
        class ArticleCreate < Grape::API
          namespace :article do
            desc 'Ảticle create'
            params do
              requires :name, type: String, desc: 'Type name'
              requires :content, type: String, desc: 'Type content'
              requires :category_id, type: Integer, desc: 'Type category id'
              optional :isShow, type: Boolean, desc: 'Type available'
            end
            post do

              user = current_user
              article = user.articles.new(params)

              if article.save
                status 200
                article
              end
            end
          end
        end
      end
    end
  end
