require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to :project }
  it { should belong_to :user }
end
