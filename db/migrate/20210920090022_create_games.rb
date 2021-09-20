class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.boolean :is_over
      t.json :user_board
      t.json :mines_board
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
