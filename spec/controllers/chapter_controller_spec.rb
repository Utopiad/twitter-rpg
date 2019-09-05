# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChapterController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #view' do
    it 'returns http success' do
      get :view
      expect(response).to have_http_status(:success)
    end
  end
end
