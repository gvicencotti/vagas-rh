require 'rails_helper'

RSpec.describe Candidature, type: :model do
  it { should belong_to(:vacancy) }
  it { should belong_to(:user) }
end
