# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  describe '#index' do
    subject { response }

    let(:request) { get api_v1_recipes_url, params: params }

    context 'when no ingredients given as parameters' do
      let(:params) {}

      before { request }
      it { is_expected.to have_http_status(:bad_request) }
    end

    context 'when ingredients given as parameters' do
      let(:params) { { ingredients: %w[sugar vanilla] } }
      let!(:recipe) { create(:recipe, payload: { 'recipe': 'my_recipe' }) }

      before do
        expect(Recipe).to receive(:rated_by_ingredients).and_return([recipe])
        request
      end

      it { is_expected.to have_http_status(:ok) }

      it 'makes a query to recipe model to get recipes' do
        expect(response.body).to eq([recipe.payload].to_json)
      end
    end
  end
end
