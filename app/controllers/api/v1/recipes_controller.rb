# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def index
        render json: Recipe.rated_by_ingredients(recipe_params).map(&:payload)
      end

      private

      def recipe_params
        params.require(:ingredients)
      end
    end
  end
end
