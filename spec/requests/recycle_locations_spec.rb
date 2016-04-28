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

      expect(stations).to eq(1)
      expect(json['recycle_locations'].size)
        .to eq(1)
      expect(json['recycle_locations'][0]['name'])
        .to eq(recycle_location.name)
      expect(json['recycle_locations'][0]['kind'])
        .to eq(recycle_location.kind)
      expect(json['recycle_locations'][0]['materials'])
        .to eq(recycle_location.materials)
      expect(json['recycle_locations'][0]['street_name'])
        .to eq(recycle_location.street_name)
      expect(json['recycle_locations'][0]['zip_code'])
        .to eq(recycle_location.zip_code)
      expect(json['recycle_locations'][0]['city'])
        .to eq(recycle_location.city)
    end
  end
end
