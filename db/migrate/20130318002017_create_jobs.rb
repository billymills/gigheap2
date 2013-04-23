class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :compay
      t.string :location

      t.timestamps
    end
  end
end
