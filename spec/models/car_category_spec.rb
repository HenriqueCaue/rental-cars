require 'rails_helper'
describe CarCategory, type: :model do
  context 'name' do
    it 'cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:name]).to include("não pode ficar em branco")
    end

    it 'must be uniq' do
      CarCategory.create!(name: 'Básico', daily_rate: '100', car_insurance: '1000', 
                          third_part_insurance: '2000')
      carcategory = CarCategory.new(name: 'Básico')

      carcategory.valid?

      expect(carcategory.errors[:name]).to include('já está em uso')
    end
  end

  context 'daily rate' do
    it 'cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:daily_rate]).to include('não pode ficar em branco')
    end

    it 'must be greater than 0' do
      carcategory = CarCategory.create(name: 'Básico', daily_rate: -10, 
                                  car_insurance: 1000, third_part_insurance: 2000)
    
      carcategory.valid?

      expect(carcategory.errors[:daily_rate]).to include('deve ser maior que 0')
    end
  end

  context 'car insurance' do
    it 'cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:car_insurance]).to include('não pode ficar em branco')
    end

    it 'must be greater than 0' do
      carcategory = CarCategory.create(name: 'Básico', daily_rate: 100, 
                                  car_insurance: -10, third_part_insurance: 2000)
    
      carcategory.valid?

      expect(carcategory.errors[:car_insurance]).to include('deve ser maior que 0')
    end
  end

  context 'third party insurance' do
    it 'cannot be blank' do
      carcategory = CarCategory.new

      carcategory.valid?

      expect(carcategory.errors[:third_part_insurance]).to include('não pode '\
                                                    'ficar em branco')
    end

    it 'must be greater than 0' do
      carcategory = CarCategory.create(name: 'Básico', daily_rate: 100, 
                                  car_insurance: 1000, third_part_insurance: -10)
    
      carcategory.valid?

      expect(carcategory.errors[:third_part_insurance]).to include('deve ser ' \
                                                        'maior que 0')
    end
  end
end
