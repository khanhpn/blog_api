module Api
    module V1
      class Root < Grape::API
        extend ActiveSupport::Concern
        version 'v1', using: :path

        helpers do
          def current_user
            auth_present = !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first
            if auth_present
              auth = Auth.decode(request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last)
              user = User.find_by(id: auth["user_id"])
              if user
                @current_user ||= user
              end
            else
              error!("không có quyền", 403)
            end
          end

          def authenticate
            current_user || error!("không có quyền", 403)
          end
        end

        mount Api::V1::TestApi::Test
        mount Api::V1::Authorization::Root
        mount Api::V1::CategoryApi::Root
        mount Api::V1::ArticleApi::Root

      end
    end
  end
