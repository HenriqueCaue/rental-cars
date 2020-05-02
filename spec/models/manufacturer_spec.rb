require 'rails_helper'

describe Manufacturer, type: :model do
  context 'validation' do
    it 'name cannot be blank' do
      user = User.create!(email: 'customer@teste.com', password: '12345678')
      login_as user, scope: :user

      manufacturer = Manufacturer.new

      manufacturer.valid?

      expect(manufacturer.errors[:name]).to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      user = User.create!(email: 'customer@teste.com', password: '12345678')
      login_as user, scope: :user
      
      Manufacturer.create!(name: 'Honda')
      manufacturer = Manufacturer.new(name: 'Honda')

      manufacturer.valid?

      expect(manufacturer.errors[:name]).to include('já está em uso')
    end
  end
end
