module Api
  module V1
    module CategoryApi
      class CategoryDelete < Grape::API
        namespace :category do
          desc 'Category delete'
          params do
            requires :id, type: Integer, desc: 'Type id'
          end
          delete ':id' do
            user = current_user
            category = user.categories.find(params[:id])
            if category.present?
              category.destroy
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
