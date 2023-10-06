
require 'rails_helper'

RSpec.describe "Api::V1::ArticleApi::ArticleList", type: :request do
  let!(:user) { create(:user) }
  let!(:categories) { create_list(:category, 5) }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  subject { get '/api/v1/category', headers: headers }

  describe "GET /api/v1/category" do
    context 'get category list success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty
        expect(body.size).to eq categories.size
      end
    end
  end
end
