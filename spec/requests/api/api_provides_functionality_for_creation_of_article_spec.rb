RSpec.describe "POST /api/articles", type: :request do

  describe "the happy path" do
     before do
    post '/api/articles', params: {
      article: {
         title: 'Not so fun with Node', 
         body: 'Is is a configuration hell' 
        }
      }
  end

  it 'is expected to respond with 201' do
    expect(response).to have_http_status 201
  end

  it 'is expected to respond with success message' do
    expect(JSON.parse(response.body)['message']).to eq 'Your article was successfully created'
  end
  end

  describe "the sad path" do
    before do
      post '/api/articles', params: {
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