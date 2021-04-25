class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.string :like_type
      t.string :like_type_id
      t.references :likable, polymorphic: true, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
