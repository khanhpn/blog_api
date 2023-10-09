require 'rails_helper'

RSpec.describe "Api::V1::CategoryApi::CategoryUpdate", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let(:name) { 'Category update test' }
  let(:isShow) { false }
  let(:params) { {name: name, isShow: isShow, id: category.id} }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  subject { patch "/api/v1/category/#{category.id}", params: params, headers: headers }

  describe "PATCH /api/v1/category/:id" do
    context 'update category with full information success' do
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
