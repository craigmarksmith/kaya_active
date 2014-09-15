ActiveAdmin.register Enquiry do

  actions :all, except: [:destroy, :edit]

  controller do
    def scoped_collection
      Enquiry.where(archived: false)
    end
  end

  index do
    column :name
    column :email_address
    column :mobile_number
    column :message
    column "Received at", :created_at
    actions defaults: true do |enquiry|
      link_to 'Archive', archive_admin_enquiry_path(enquiry), data: {method: :post, confirm: "Are you sure?"}
    end
  end

  member_action :archive, method: :post do
    Enquiry.find(params[:id]).update_attribute(:archived, true)
    redirect_to :back
  end

end
