require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should have_many :messages }
  it { should have_many :audits }
end
