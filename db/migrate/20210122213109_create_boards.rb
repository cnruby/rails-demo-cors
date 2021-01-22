class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :size
      t.belongs_to :surfer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
