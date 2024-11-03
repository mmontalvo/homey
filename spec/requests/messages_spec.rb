require 'rails_helper'
require 'shared_contexts'

RSpec.describe "/messages", type: :request do
  include_context "authentication helper methods"

  let(:valid_attributes) {
    {
      body: 'Message body',
      project_id: project.id
    }
  }

  let(:invalid_attributes) {
    { invalid_attribute: 'foo' }
  }

  let(:user) { create(:user) }
  let(:project) { create(:project) }

  before(:each) { sign_in(user) }

  describe "GET /new" do
    it "renders a successful response" do
      get new_message_url(project_id: project.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before do
      allow(Events::Messages::Create).to receive(:publish).and_call_original
    end

    context "with valid parameters" do
      it "creates a new Message" do
        expect {
          post messages_url, params: { message: valid_attributes }
        }.to change(Message, :count).by(1)
      end

      it "Events::Projects::StatusUpdate is called" do
        post messages_url, params: { message: valid_attributes }

        expect(Events::Messages::Create).to have_received(:publish)
      end

      it "redirects to the associated project" do
        post messages_url, params: { message: valid_attributes }
        expect(response).to redirect_to(project_url(Message.last.project))
      end
    end
  end
end
