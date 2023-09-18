module Api
    module V1
      module TestApi
        class Test < Grape::API
          namespace :test do
            desc 'Client List'
            get do
              status 200
              'Hello'
            end
          end
        end
      end
    end
  end
