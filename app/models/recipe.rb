# frozen_string_literal: true

class Recipe < ApplicationRecord
  scope :rated_by_ingredients, lambda { |ingredients|
    rank = "ts_rank(to_tsvector('english', payload->'ingredients'), to_tsquery(?))"
    where("to_tsvector('english', payload->'ingredients') @@ to_tsquery(?)", ingredients.join(' | '))
      .order(Arel.sql("#{sanitize_sql_for_order([Arel.sql(rank), ingredients.join(' | ')])} DESC, payload->>'ratings' DESC"))
  }
end
