# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Recipe, type: :model do
  describe '.rated_by_ingredients' do
    let(:recipe_with_salt) do
      {
        "title": 'Golden Sweet Cornbread',
        "ingredients": [
          '⅔ cup white sugar',
          '1 teaspoon salt',
          '3 ½ teaspoons baking powder',
          '1 egg',
          '1 cup milk',
          '⅓ cup vegetable oil'
        ],
        "ratings": 4.75
      }
    end

    let(:recipe_without_salt) do
      {
        "title": 'Golden Sweet Cornbread without Salt',
        "ingredients": [
          '⅔ cup white sugar',
          '3 ½ teaspoons baking powder',
          '1 egg',
          '1 cup milk',
          '⅓ cup vegetable oil'
        ],
        "ratings": 4.74
      }
    end

    let(:recipe_with_coffee) do
      {
        "title": 'Golden Sweet Cornbread with Coffee',
        "ingredients": [
          '⅔ cup white sugar',
          '1 teaspoon coffee',
          '3 ½ teaspoons baking powder',
          '1 egg',
          '1 cup milk',
          '⅓ cup vegetable oil'
        ],
        "ratings": 4.54
      }
    end

    let!(:recipe_with_salt_record) { create(:recipe, payload: recipe_with_salt) }
    let!(:recipe_without_salt_record) { create(:recipe, payload: recipe_without_salt) }
    let!(:recipe_with_coffee_record) { create(:recipe, payload: recipe_with_coffee) }

    context 'when a ingredient added to query' do
      it 'should return recipes with at least that ingredient' do
        expect(described_class.rated_by_ingredients(%w[salt])).to include(recipe_with_salt_record)
        expect(described_class.rated_by_ingredients(%w[salt])).not_to include(recipe_without_salt_record)
      end
    end

    context 'when several ingredients added to query' do
      it 'should return recipes with one or more ingredients added to the query ordered by rank and rating' do
        expect(described_class.rated_by_ingredients(%w[coffee milk]))
          .to eq([recipe_with_coffee_record, recipe_with_salt_record, recipe_without_salt_record])
      end
    end
  end
end
