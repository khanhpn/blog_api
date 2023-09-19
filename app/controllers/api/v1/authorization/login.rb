module Api
  module V1
    module Authorization
      class Login < Grape::API
        namespace :authorization do
          desc 'Client List'
          params do
            requires :email, type: String, desc: 'Type email address'
            requires :password, type: String, desc: 'Type password'
          end
          post 'login' do
            user = User.find_by(email: params[:email])
            if user.present? && user.authenticate(params[:password])
              jwt = Auth.encode({user_id: user.id})
              status 200
              {jwt: jwt}
            end
          end
        end
      end
    end
  end
end
