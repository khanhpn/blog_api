module Api
  module V1
    module CategoryApi
      class CategoryList < Grape::API
        namespace :category do
          desc 'list of category'
          get do
            categories = Category.all
            status 200
            categories
          end
        end
      end
    end
  end
end
