require 'rails_helper'

RSpec.describe AuditsChannel, type: :channel do
  it "successfully subscribes" do
    subscribe
    expect(subscription).to be_confirmed
  end

  it "successfully receives data" do
    subscribe

    expect {
      perform :receive, email: 'test@test.com'
    }.to have_broadcasted_to("audits_channel").with({ "email": "test@test.com", "action": "receive" })
  end
end
