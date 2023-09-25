require 'rails_helper'

RSpec.describe "Api::V1::Authorization::Register", type: :request do
  let(:email) { 'test@gmail.com' }
  let(:password) { '12345678' }
  let(:password_confirmation) { '12345678' }
  let(:params) { { email: email, password: password, password_confirmation: password_confirmation } }

  subject { post '/api/v1/authorization/register', params: params }

  describe "POST /api/v1/authorization/register" do
    context 'with full information success' do
      it 'expected status 200 and success json object' do
        subject
        body = JSON.parse(response.body)
        status = response.status

        expect(status).to eq 200
        expect(body).not_to be_empty

        expect(body['email']).to eq email
      end
    end

    context 'register failed' do
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
