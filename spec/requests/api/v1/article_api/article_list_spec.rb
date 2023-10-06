
require 'rails_helper'

RSpec.describe "Api::V1::ArticleApi::ArticleList", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:articles) { create_list(:article, 5) }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  subject { get '/api/v1/article', headers: headers }

  describe "GET /api/v1/article" do
    context 'get article list success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty
        expect(body.size).to eq articles.size
      end
    end
  end
end
