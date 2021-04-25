RSpec.describe "POST /api/articles", type: :request do
let(:user) { create(:user)}
let(:user_credentials) { user.create_new_auth_token}

  describe "successfully creates new article" do
    before do
      post '/api/articles', params: {
      article: {
         title: 'Not so fun with Node', 
         body: 'Is is a configuration hell' 
        }
      },
      headers: user_credentials
    end

    it 'is expected to respond with 201' do
      expect(response).to have_http_status 201
    end

    it 'is expected to respond with success message' do
      expect(response_json['message']).to eq 'Your article was successfully created'
    end
  end

  describe "is unsuccessfull to create without a title" do
    before do
      post '/api/articles', params: {
        article: {
           title: '', 
           body: 'Is is a configuration hell' 
          }
        },
        headers: user_credentials
    end

    it 'is expected to respond with 422' do
      expect(response).to have_http_status 422
    end

    it 'is expected to respond with an error message' do
      expect(response_json['message']).to eq 'Title can\'t be blank'
    end
  end
 
  describe "unsuccesfull to create article if user is not signed in" do
    before do
      post '/api/articles', params: {
        article: {
          title: '', 
          body: 'Is is a configuration hell' 
        }
      }
    end

    it 'is expected to respond with 401' do
      expect(response).to have_http_status 401
    end

    it 'is expected to respond with an error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end