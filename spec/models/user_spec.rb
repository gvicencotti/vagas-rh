require 'rails_helper'

describe User do
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