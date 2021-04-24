RSpec.describe "PUT /api/articles/:id", type: :request do
  let!(:article) { create(:article, title: 'old title', body: 'old body') }
  describe "the happy path" do
    before do
      put "/api/articles/#{article.id}", params: {
      article: {
         title: 'updeted title', 
         body: 'updated body' 
        }
      }
    end

    it 'is expected to respond with 204' do
      expect(response).to have_http_status 204
    end

    it 'is expected to respond with success message' do
      expect(JSON.parse(response.body)['message']).to eq 'Your article was successfully updated'
    end

    it 'is expected to update title' do
      expect(JSON.parse(response.body)['article']['title']).to eq 'updeted title'
    end

    it 'is expected to update body' do
      expect(JSON.parse(response.body)['article']['body']).to eq 'updeted body'
    end
  end

  describe "the sad path" do
    before do
      put '/api/articles', params: {
        article: {
           title: '', 
           body: 'Is is a configuration hell' 
          }
        }
    end

    it 'is expected to respond with 422' do
      expect(response).to have_http_status 422
    end

    it 'is expected to respond with an error message' do
      expect(JSON.parse(response.body)['message']).to eq 'Title can\'t be blank'
    end
  end
end