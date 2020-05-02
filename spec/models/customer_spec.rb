require 'rails_helper'

describe Customer, type: :model do
  context '#name' do
    it 'cannot be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:name]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      Customer.create!(name: 'João', document: '820.286.340-65', email: 'customer@gmail.com')

      customer = Customer.new(name:'João')

      customer.valid?

      expect(customer.errors[:name]).to include('já está em uso')
    end
  end

  context '#document' do
    it 'cannot be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:document]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      Customer.create!(name: 'João', document: '820.286.340-65', email: 'customer@gmail.com')

      customer = Customer.new(document:'820.286.340-65')

      customer.valid?

      expect(customer.errors[:document]).to include('já está em uso')
    end

    it 'must be valid format' do
      customer = Customer.new(document: '820.286.340-00')

      customer.valid?

      expect(customer.errors[:document]).to include('não é válido')
    end
    
    #it 'must be valid length' do
    #  customer = Customer.new(document: '820.286.340-00')
    #  customer.valid?
    #  expect(customer.errors[:document]).to include('Digite os pontos e o traço')
    #end
  end

  context '#email' do
    it 'cannot be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:email]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      Customer.create!(name: 'João', document: '820.286.340-65', email: 'customer@gmail.com')

      customer = Customer.new(email:'customer@gmail.com')

      customer.valid?

      expect(customer.errors[:email]).to include('já está em uso')
    end
  end
end
