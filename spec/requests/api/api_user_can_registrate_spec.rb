RSpec.describe 'POST /api/auth', type: :request do
  describe 'Can register a user' do
    before do
      post '/api/auth',
        params: {
          email: 'burgar@bengt.com',
          password: 'password',
          password_confirmation: 'password'
        }
    end
    
    it 'returns 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns the expected response' do
      expect(response_json['status']).to eq "success"
    end

    it 'returns the expected data' do
      expected_response = {
        'data' => {
          'id' => response_json['data']['id'],
          'uid' => 'burgar@bengt.com',
          'email' => 'burgar@bengt.com',
          'provider' => 'email',
          'allow_password_change' => false,
          'created_at' => response_json['data']['created_at'],
          'updated_at' => response_json['data']['updated_at']
        }
      }
      expect(response_json['data']).to eq expected_response['data']
    end
  end

  describe 'Can register a user' do
    before do
      post '/api/auth',
        params: {
          email: 'my@email.com',
          password: 'password',
          password_confirmation: 'wrong_pw'
        }
    end
    
    it 'returns 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns the expected response' do
      expect(response_json['errors']['password_confirmation'].first).to eq "doesn't match Password"
    end
  end
end