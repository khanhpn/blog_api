module Api
  module V1
    module CategoryApi
      class CategoryCreate < Grape::API
        namespace :category do
          desc 'Category update'
          params do
            requires :id, type: Integer, desc: 'Type id'
            optional :name, type: String, desc: 'Type name'
            optional :isShow, type: Boolean, desc: 'Type available'
          end
          patch ':id' do
            user = current_user
            category = user.categories.new(params)
            if category.save
              status 200
              category
            end
          end
        end
      end
    end
  end
end
