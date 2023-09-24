module Api
  module V1
    module CategoryApi
      class CategoryUpdate < Grape::API
        namespace :category do
          desc 'Category update'
          params do
            requires :id, type: Integer, desc: 'Type id'
            optional :name, type: String, desc: 'Type name'
            optional :isShow, type: Boolean, desc: 'Type available'
          end
          patch ':id' do
            user = current_user
            category = user.categories.find(params[:id])
            if category.present?
              category.update(params)
              status 200
              category
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
