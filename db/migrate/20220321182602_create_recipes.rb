class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.jsonb :payload

      t.timestamps
    end

    add_index :recipes, "to_tsvector('english', payload->'ingredients')", using: :gin,
                                                                          name: 'index_recipes_on_payload_ingredients'
    add_index :recipes, "to_tsvector('english', payload->'title')", using: :gin, name: 'index_recipes_on_payload_title'
  end
end
