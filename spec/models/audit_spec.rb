require 'rails_helper'

RSpec.describe Audit, type: :model do
  it { should belong_to :project }
  it { should belong_to :user }
end
