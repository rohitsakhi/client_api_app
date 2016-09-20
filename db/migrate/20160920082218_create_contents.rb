class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :url
      t.text  :links
      t.text  :h1
      t.text  :h2
      t.text  :h3
      t.text  :h6
      t.text  :p
      t.text  :button
      t.timestamps null: false
    end
  end
end
