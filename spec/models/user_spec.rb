require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  
  it 'attributes cannot be blank' do
    user = User.new

    expect(user.valid?).to eq false
    expect(user.errors.count).to eq 2
  end

  it 'errors messages are in portuguese' do
    user = User.new

    user.valid?

    expect(user.errors[:email]).to include('não pode ficar em branco')
    expect(user.errors[:password]).to include('não pode ficar em branco')
  end
end