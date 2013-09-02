ActiveAdmin.register User do

#can be wiewed into index user top right
# action_item only: :index do |resource|
#   link_to('New Post', new_resource_path(resource))
# end

member_action :ban, :method => :put do
    User.find(params[:id]).toggle!(:banned)
    redirect_to [:admin, resource], :notice => "User banned!"
  end

index do
	column :id
    column :username
    column :name
    column :email
    column :banned, :sortable => :banned do |user|
        status_tag ( user.banned ? "Banned" : "Not Banned"), ( user.banned ? :error : :ok) 
    end
    column :confirmed_user, :sortable => :confirmed_user do |user|
        status_tag ( user.confirmed_user ? "Active" : "Unconfirmed"), ( user.confirmed_user ? :ok : :error) 
    end
    column "Sign Up Date", :created_at
    column "# of reports" do |user|
      	user.reports.count
    end
    actions defaults: true do |user|
      link_to user.banned ? "Remove Ban" : "Ban", ban_admin_user_path(user), :method => :put
    end
  end

	form do |f|
      f.inputs "User Data" do
        f.input :username
        f.input :name
        f.input :email
      end
      f.inputs "Status" do
        f.input :banned, as: :boolean
        f.input :confirmed_user, as: :boolean
      end
      f.actions
    end

   show do |user|
      attributes_table do
        row :id
        row :username
        row :name
        row :email
        row :banned
        row :confirmed_user
        panel "Reports" do
			table_for user.reports do |t|  
				t.column("Id") { |report| report.id }
		 		t.column("Content") { |report| report.content }
        t.column("Reported by") { |report| report.reported_by.name }
		 	end
	 	end
      end
    end

end
