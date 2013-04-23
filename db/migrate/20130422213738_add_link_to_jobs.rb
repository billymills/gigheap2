class AddLinkToJobs < ActiveRecord::Migration
  def change
    add_column :Jobs, :link, :string
  end
end
