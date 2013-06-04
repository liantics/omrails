class Fiximageremoteurlcolumnname < ActiveRecord::Migration
  def change
  	rename_column :pins, :imge_remote_url, :image_remote_url
  end

  def down
  end
end
