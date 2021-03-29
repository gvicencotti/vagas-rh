require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of(:company_name) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:district) }
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:site) }

  it 'attributes cannot be blank' do
    company = Company.new

    expect(company.valid?).to eq false
    expect(company.errors.count).to eq 6
  end

end
