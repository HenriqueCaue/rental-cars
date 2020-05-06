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
    
    it 'must be valid formatation' do
      customer = Customer.new(document: '82028634065')
      customer.valid?
      expect(customer.errors[:document]).to include('Digite os pontos e o traço')
    end

    it 'must be valid length' do
      customer = Customer.new(document: '82028634065')
      customer.valid?
      expect(customer.errors[:document]).to include('não possui o tamanho esperado (14 caracteres)')
    end
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

    it 'must be valid' do
      customer = Customer.new(email: 'cus,tomer@gmail.com')

      customer.valid?

      expect(customer.errors[:email]).to include('não é válido')
    end
  end

  context 'search' do
    it 'by exact name' do

      customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
                                  email: 'test@test.com')
      another_customer = Customer.create!(name: 'João da Silva', 
                                          document: '581.280.655-13', 
                                          email: 'test@email.com')

      result = Customer.search('Fulano Sicrano')

      expect(result).to include(customer)
      expect(result).not_to include(another_customer)

    end
    it 'by partial name' do

      customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
                                  email: 'test@test.com')
      another_customer = Customer.create!(name: 'João da Silva', 
                                          document: '581.280.655-13', 
                                          email: 'test@email.com')

      result = Customer.search('fulano')

      expect(result).to include(customer)
      expect(result).not_to include(another_customer)
    end

    it 'finds nothing' do
      customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
                                  email: 'test@test.com')
      another_customer = Customer.create!(name: 'João da Silva', 
                                          document: '581.280.655-13', 
                                          email: 'test@email.com')

      result = Customer.search('test')

      expect(result).to be_blank
    end

    it 'by cpf' do
      customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
                                  email: 'test@test.com')
      another_customer = Customer.create!(name: 'João da Silva', 
                                          document: '581.280.655-13', 
                                          email: 'test@email.com')

      result = Customer.search('100.954.020-39')

      expect(result).to include(customer)
      expect(result).not_to include(another_customer)
    end
  end
end
