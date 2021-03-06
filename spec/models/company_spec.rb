require 'rails_helper'

describe Company do
  it 'attributes cannot be blank' do
    company = Company.new

    expect(company.valid?).to eq false
    expect(company.errors.count).to eq 6
  end

  it 'errors messages are in portuguese' do
    company = Company.new

    company.valid?

    expect(company.errors[:company_name]).to include('não pode ficar em branco')
    expect(company.errors[:city]).to include('não pode ficar em branco')
    expect(company.errors[:address]).to include('não pode ficar em branco')
    expect(company.errors[:district]).to include('não pode ficar em branco')
    expect(company.errors[:cnpj]).to include('não pode ficar em branco') 
    expect(company.errors[:site]).to include('não pode ficar em branco')
  end
end
