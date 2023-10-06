require 'rails_helper'

RSpec.describe "Api::V1::Authorization::Login", type: :request do
  let(:email) { 'test@gmail.com' }
  let(:password) { '12345678' }
  let!(:user) { create(:user) }

  let(:params) { { email: email, password: password } }

  subject { post '/api/v1/authorization/login', params: params }

  describe "POST /api/v1/authorization/login" do
    context 'with login success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty
      end
    end

    context 'login failed' do
      let(:password) { '123456789' }
      it 'expected status 200 and success json object' do
        subject

        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 401
      end
    end
  end
end
