require 'rails_helper'
describe CarCategory, type: :model do
  context 'validation' do
    it 'name cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:name]).to include('Nome não pode '\
                                                    'ficar em branco')
    end

    it 'daily rate cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:daily_rate]).to include('Taxa diária não pode '\
                                                    'ficar em branco')
    end

    it 'car insurance cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:car_insurance]).to include('Seguro do carro não pode '\
                                                    'ficar em branco')
    end

    it 'third party insurance cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:third_party_insurance]).to include('Seguro contra terceiros não pode '\
                                                    'ficar em branco')
    end

    it 'name must be uniq' do
      CarCategory.create!(name: 'Básico', daily_rate: '100', car_insurance: '1000', third_party_insurance: '2000')
      carcategory = CarCategory.new(name: 'Básico')

      carcategory.valid?

      expect(carcategory.errors[:name]).to include('Nome deve ser único')
    end
  end
end
