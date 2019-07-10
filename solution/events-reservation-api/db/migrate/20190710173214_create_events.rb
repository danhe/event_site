class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :type, null: false
      t.string :speaker
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :name, null: false
      t.string :location
      t.text :description
      t.integer :max_participants, default: 1

      t.timestamps
    end
  end
end
