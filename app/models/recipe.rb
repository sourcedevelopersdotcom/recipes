class Recipe < ApplicationRecord
  scope :rated_by_ingredients, lambda { |ingredients|
    where("to_tsvector('english', payload->'ingredients') @@ to_tsquery(?)", ingredients.join(' & '))
      .order(Arel.sql("payload->>'ratings' DESC"))
  }
end
