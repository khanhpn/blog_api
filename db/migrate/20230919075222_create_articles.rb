class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :content
      t.boolean :isShow
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
