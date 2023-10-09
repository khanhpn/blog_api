require 'rails_helper'

RSpec.describe "Api::V1::CategoryApi::CategoryCreate", type: :request do
  let!(:user) { create(:user) }
  let(:name) { 'Category test' }
  let(:isShow) { true }
  let(:params) { { name: name, isShow: isShow} }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  subject { post '/api/v1/category', params: params, headers: headers }

  describe "POST /api/v1/category" do
    context 'create category with full information success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty

        expect(body['name']).to eq name
      end
    end

    context 'create category failed' do
      let(:password_confirmation) { '123456789' }
      it 'expected status 200 and success json object' do
        subject

        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 400
      end
    end
  end
end
