require 'rails_helper'

RSpec.describe 'Assessments', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST assessment#create' do
    subject(:assessment_attrs) { attributes_for(:assessment) }

    let(:valid_assessment_params) do
      {
        assessment: {
          value: assessment_attrs[:value],
          comment: assessment_attrs[:comment]
        }
      }
    end

    it "redirects to the user's page" do
      post user_assessments_path(user), params: valid_assessment_params

      expect(response).to redirect_to user
    end

    it 'creates an assessment' do
      expect do
        post user_assessments_path(user), params: valid_assessment_params
      end.to change(Assessment, :count).by(1)
    end
  end

  describe 'DELETE assessment#destroy' do
    subject!(:existing_assessment) { create(:assessment, target: user) }

    it "redirects to the users's page" do
      delete user_assessments_path(user), params: { id: existing_assessment.id }
      expect(response).to redirect_to user
    end

    it 'destroys an assessment' do
      expect do
        delete user_assessments_path(user), params: { id: existing_assessment.id }
      end.to change(Assessment, :count).by(-1)
    end
  end
end
