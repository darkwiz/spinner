ActiveAdmin.register ReportUser, :as => "Reported Users" do
  menu :parent => 'Report'
   	index do
    	column :id
    	column :content
    	column "Reported User" do |report|
        	link_to report.user.name, admin_user_path(report.user)
    	end
    	column :reported_by

     default_actions
  end

  show do |report|
      attributes_table do
        row :id
        row :reported_by
        row :content
        row ("Reported User") { |report| link_to report.user.name, admin_user_path(report.user) }
        row :created_at
        row :updated_at
      end
    end
end
