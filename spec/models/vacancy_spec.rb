require 'rails_helper'

describe Vacancy do
  it 'attributes cannot be blank' do
    vacancy = Vacancy.new

    expect(vacancy.valid?).to eq false
    expect(vacancy.errors.count).to eq 6
  end

  it 'errors messages are in portuguese' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:company]).to include('não pode ficar em branco')
    expect(vacancy.errors[:role]).to include('não pode ficar em branco')
    expect(vacancy.errors[:description]).to include('não pode ficar em '\
                                                          'branco')
    expect(vacancy.errors[:requirements]).to include('não pode ficar em'\
                                                            ' branco')
    expect(vacancy.errors[:localization]).to include('não pode ficar em'\
                                                            ' branco')
    expect(vacancy.errors[:expiration_date]).to include('não pode ficar em'\
                                                              ' branco')                                                      
  end
end
