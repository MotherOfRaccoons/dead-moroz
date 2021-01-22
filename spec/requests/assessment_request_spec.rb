require 'rails_helper'

RSpec.describe 'Assessments', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST assessment#create' do
    subject(:assessment_attrs) { attributes_for(:assessment) }

    it 'creates an assessment' do
      post "/users/#{user.id}/assessments/", params: {
        assessment: {
          value: assessment_attrs[:value],
          body: assessment_attrs[:comment]
        }
      }
      expect(response).to redirect_to user
    end
  end

  describe 'DELETE assessment#destroy' do
    subject!(:existing_assessment) { create(:assessment) }

    it 'deletes an existing assessment' do
      delete "/users/#{user.id}/assessments", params: { id: existing_assessment.id }
      expect(response).to redirect_to user
    end
  end
end
