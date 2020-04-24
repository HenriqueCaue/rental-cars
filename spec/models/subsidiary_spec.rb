require 'rails_helper'

describe Subsidiary, type: :model do
  context '#name' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(name: '')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Nome não pode '\
                                                    'ficar em branco')
    end

    it 'must be uniq' do
      Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua joa de Barro')
      subsidiary = Subsidiary.new(name: 'São Paulo')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Nome deve ser único')
    end
  end

  context '#cnpj' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(cnpj: '')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ não pode '\
                                                    'ficar em branco')
    end

    it 'must be uniq' do
      Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua joa de Barro')
      subsidiary = Subsidiary.new(cnpj: '22.880.353/0001-66')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ deve ser único')
    end

    it 'must be valid format' do
      subsidiary = Subsidiary.new(cnpj: '23.534.432/0010-00')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end
  end

  context '#address' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:address]).to include('Endereço não pode '\
                                                    'ficar em branco')
    end

    it 'must be uniq' do
      Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua joa de Barro')
      subsidiary = Subsidiary.new(address: 'Rua joa de Barro')

      subsidiary.valid?

      expect(subsidiary.errors[:address]).to include('Endereço deve ser único')
    end
  end
end
