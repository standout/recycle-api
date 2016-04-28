require 'rails_helper'

RSpec.describe 'Recycle locations API', type: :request do
  describe 'GET /recycle_locations' do
    it 'returns 200 OK' do
      recycle_location = create(:recycle_location)

      get '/recycle_locations', headers: { 'Accept': 'application/json' }

      expect(response.status).to eq(200)
    end

    it 'returns a list of recycle locations as JSON' do
      recycle_location = create(:recycle_location)

      get '/recycle_locations', headers: { 'Accept': 'application/json' }

      expect(response)
        .to match_response_schema("recycle_locations", strict: true)
    end
  end
end
