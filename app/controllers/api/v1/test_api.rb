module Api
    module V1
      module TestApi
        class Test < Grape::API
          namespace :test do
            desc 'Client List'
            get do
              if authenticate
                status 200
                'Hello'
              else
                status 400
              end
            end
          end
        end
      end
    end
  end
