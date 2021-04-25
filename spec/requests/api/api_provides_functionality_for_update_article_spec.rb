RSpec.describe "PUT /api/articles/:id", type: :request do
  let(:user) { create(:user)}
  let(:user_credentials) { user.create_new_auth_token}
  let!(:article) { create(:article, title: 'old title', body: 'old body') }

  describe "User is signed in and can update article" do
    before do
      put "/api/articles/#{article.id}",
      params: {
        article: {
           title: 'updated title', 
           body: 'updated body' 
        }
      },
      headers: user_credentials
    end

    it 'is expected to respond with 202' do
      expect(response).to have_http_status 202
    end

    it 'is expected to respond with success message' do
      expect(response_json["message"]).to eq "Your article was successfully updated"
    end

    it 'is expected to update title' do
      expect(response_json['article']['title']).to eq 'updated title'
    end

    it 'is expected to update body' do
      expect(response_json['article']['body']).to eq 'updated body'
    end
  end

  describe "User not singed in and can't update article" do
    before do
      put "/api/articles/#{article.id}",
      params: {
        article: {
           title: 'updated title', 
           body: 'updated body' 
        }
      }
    end

    it 'is expected to respond with 401' do
      expect(response).to have_http_status 401
    end

    it 'is expected to respond with success message' do
      expect(response_json["errors"].first).to eq "You need to sign in or sign up before continuing."
    end
  end
end