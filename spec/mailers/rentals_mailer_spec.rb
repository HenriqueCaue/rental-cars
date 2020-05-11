require 'rails_helper'

describe RentalsMailer do
  context '#scheduled' do
    it 'renders the subject' do
      customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
        email: 'customer@gmail.com')
    
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                          third_part_insurance: 100)
    
      rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, 
                                customer: customer, car_category: car_category)
                      
      #mail = RentalsMailer.scheduled(rental)
      mail = RentalsMailer.with(rental: rental).scheduled(rental)

      expect(mail.subject).to eq("Confirmação de Agendamento - #{rental.code}")
    end

    it 'renders receiver' do
      customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
        email: 'customer@gmail.com')
    
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                          third_part_insurance: 100)
    
      rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, 
                                customer: customer, car_category: car_category)
                      
      mail = RentalsMailer.with(rental: rental).scheduled(rental)

      expect(mail.to).to eq([rental.customer.email])
    end

    it 'render mail sender' do
      customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
        email: 'customer@gmail.com')
    
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
                                          car_insurance: 100, 
                                          third_part_insurance: 100)
    
      rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, 
                                customer: customer, car_category: car_category)
                      
      mail = RentalsMailer.with(rental: rental).scheduled(rental)

      expect(mail.from).to eq(["no-reply@rentalcars.com.br"])
    end

    it 'renders mail body' do
      customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
        email: 'customer@gmail.com')
    
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
                                          car_insurance: 100, 
                                          third_part_insurance: 100)
    
      rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, 
                                customer: customer, car_category: car_category)
                      
      mail = RentalsMailer.with(rental: rental).scheduled(rental)

      expect(mail.body.encoded).to match(rental.code)
      expect(mail.body.encoded).to match(I18n.l (rental.start_date))
      expect(mail.body.encoded).to match(I18n.l (rental.end_date))
    end
  end
end