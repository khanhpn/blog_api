require 'rails_helper'

RSpec.describe "Api::V1::ArticleApi::ArticleCreate", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let(:name) { 'Article test' }
  let(:content) { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.' }
  let(:isShow) { true }
  let(:params) { { name: name, isShow: isShow, content: content, category_id: category.id} }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  subject { post '/api/v1/article', params: params, headers: headers }

  describe "POST /api/v1/article" do
    context 'create article with full information success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty

        expect(body['name']).to eq name
      end
    end

  end
end
