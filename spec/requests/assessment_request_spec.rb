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
          body: assessment_attrs[:comment]
        }
      }
    end

    specify do
      post user_assessments_path(user), params: valid_assessment_params
      expect(response).to redirect_to user
    end
  end

  describe 'DELETE assessment#destroy' do
    subject!(:existing_assessment) { create(:assessment, target: user) }

    specify do
      delete user_assessments_path(user), params: { id: existing_assessment.id }
      expect(response).to redirect_to user
    end
  end
end
