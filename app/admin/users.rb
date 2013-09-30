ActiveAdmin.register User do

#can be wiewed into index user top right
# action_item only: :index do |resource|
#   link_to('New Post', new_resource_path(resource))
# end

member_action :ban, :method => :put do
    user = User.find(params[:id])
    user.toggle!(:banned)
    if user.banned?
      redirect_to collection_path, :notice => "User banned!"
    else
      redirect_to collection_path, :notice => "Ban Removed!"
    end
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
      	user.report_users.count
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
			table_for user.report_users do |t|  
				t.column("Id") { |report_user| report_user.id }
		 		t.column("Content") { |reported_user| reported_user.content }
        t.column("Reported by") { |report_user| report_user.reported_by.name }
		 	end
	 	end
      end
    end

end
