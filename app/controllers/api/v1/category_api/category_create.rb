module Api
  module V1
    module CategoryApi
      class CategoryCreate < Grape::API
        namespace :category do
          desc 'Client List'
          params do
            requires :name, type: String, desc: 'Type name'
            optional :isShow, type: Boolean, desc: 'Type available'
          end
          post do
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
