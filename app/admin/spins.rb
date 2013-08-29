ActiveAdmin.register Spin do
  index do
    column :content
    column "User" do |spin|
        link_to spin.user.name, admin_user_path(spin.user)
     end
    column "Creation Date", :created_at
    column "Last Update Date", :updated_at
    default_actions
  end
  end