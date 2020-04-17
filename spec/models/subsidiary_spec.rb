require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'name cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Nome não pode '\
                                                    'ficar em branco')
    end

    it 'cnpj cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ não pode '\
                                                    'ficar em branco')
    end

    it 'address cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:address]).to include('Endereço não pode '\
                                                    'ficar em branco')
    end

    it 'name must be uniq' do
      Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua joa de Barro')
      subsidiary = Subsidiary.new(name: 'São Paulo')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Nome deve ser único')
    end

    it 'cnpj must be uniq' do
      Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua joa de Barro')
      subsidiary = Subsidiary.new(cnpj: 'XX.XXX.XXX/XXXX-XX')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ deve ser único')
    end

    it 'address must be uniq' do
      Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua joa de Barro')
      subsidiary = Subsidiary.new(address: 'Rua Joa de Barro')

      subsidiary.valid?

      expect(subsidiary.errors[:address]).to include('Endereço deve ser único')
    end
  end
end
