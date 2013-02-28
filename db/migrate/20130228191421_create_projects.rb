class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :blurb
      t.string :description
      t.string :category
      t.decimal :cost
      t.string :progressupdate

      t.timestamps
    end
  end
end
