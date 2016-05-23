class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.string :raw_from
      t.string :raw_to
      t.text :body
      t.text :headers
      t.string :subject
      t.string :inbox

      t.timestamps null: false
    end
  end
end
