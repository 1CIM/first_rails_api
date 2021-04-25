RSpec.describe "PUT /api/articles/:id", type: :request do
  let!(:article) { create(:article, title: 'old title', body: 'old body') }
  describe "the happy path" do
    before do
      put "/api/articles/#{article.id}",
      params: {
        article: {
           title: 'updated title', 
           body: 'updated body' 
        }
      }
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
end