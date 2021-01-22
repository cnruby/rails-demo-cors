class CreateSurfers < ActiveRecord::Migration[6.1]
  def change
    create_table :surfers do |t|
      t.string :name

      t.timestamps
    end
  end
end
