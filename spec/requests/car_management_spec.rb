require 'rails_helper'

describe 'Car management' do
  context 'GET /api/v1/' do
    it 'returns available cars' do
      cars = create_list(:car, 3)

      get api_v1_cars_path
      
      #json_response = JSON.parse()
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(cars.first.license_plate)
      expect(response.body).to include(cars.second.license_plate)
      expect(response.body).to include(cars.third.license_plate)
    end

    it 'returns empty array without cars' do
      get api_v1_cars_path


    end
  end
end