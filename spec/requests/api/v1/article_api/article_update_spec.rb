
require 'rails_helper'

RSpec.describe "Api::V1::ArticleApi::ArticleUpdate", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:article) { create(:article, user: user, category: category) }
  let(:jwt_token) { Auth.encode({ user_id: user.id }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  let(:params) { { id: article.id, name: 'Update Aricle', isShow: false, category_id: category.id } }

  subject { patch "/api/v1/article/#{article.id}", params: params, headers: headers }

  describe "PATCH /api/v1/article/:id" do
    context 'update article list success' do
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
