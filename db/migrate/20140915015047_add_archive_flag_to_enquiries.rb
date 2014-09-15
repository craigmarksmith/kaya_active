class AddArchiveFlagToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :archived, :boolean, default:false
  end
end
