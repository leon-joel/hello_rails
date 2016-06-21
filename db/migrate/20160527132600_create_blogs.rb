class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title

      t.timestamps null: false
    end

    change_table :entries do |t|
      t.references :blog, index: true, foreign_key: true
    end
  end
end
