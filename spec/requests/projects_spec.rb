require 'rails_helper'
require 'shared_contexts'

RSpec.describe "/projects", type: :request do
  include_context "authentication helper methods"

  let(:valid_attributes) {
    {
      title: 'title',
      status: 'active'
    }
  }

  let(:invalid_attributes) {
    {
      invalid_attribute: 'foo'
    }
  }

  let(:user) { create(:user) }

  before(:each) { sign_in(user) }

  describe "GET /index" do
    it "renders a successful response" do
      Project.create! valid_attributes
      get projects_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      project = Project.create! valid_attributes
      get project_url(project)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_project_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      project = Project.create! valid_attributes
      get edit_project_url(project)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Project" do
        expect {
          post projects_url, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the created project" do
        post projects_url, params: { project: valid_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect {
          post projects_url, params: { project: invalid_attributes }
        }.to change(Project, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post projects_url, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { title: 'New title' }
      }

      before do
        allow(Events::Projects::StatusUpdate).to receive(:publish).and_call_original
      end

      it "updates the requested project" do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(project.title).to eq(new_attributes[:title])
      end

      it "Events::Projects::StatusUpdate is called" do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: new_attributes }

        expect(Events::Projects::StatusUpdate).to have_received(:publish)
      end

      it "redirects to the project" do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(response).to redirect_to(project_url(project))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete project_url(project)
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete project_url(project)
      expect(response).to redirect_to(projects_url)
    end
  end
end
