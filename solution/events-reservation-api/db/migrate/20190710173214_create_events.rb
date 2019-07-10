class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :type
      t.string :speaker
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.string :location
      t.text :description
      t.integer :max_participants, default: 1

      t.timestamps
    end
  end
end
