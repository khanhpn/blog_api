
require 'rails_helper'

RSpec.describe "Api::V1::CategoryApi::CategoryDelete", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  let(:params) { { id: category.id} }

  subject { delete "/api/v1/category/#{category.id}", params: params, headers: headers }

  describe "DELETE /api/v1/category/:id" do
    context 'delete category list success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty
      end
    end
  end
end
