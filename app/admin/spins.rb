ActiveAdmin.register Spin do  
  scope :all, :default => true
  scope :multimedia do |spins|
      spins.where('type = :spin_type', spin_type: 'Multispin')
  end
  

  index do
    column :id
    column :content
    column "User" do |spin|
        link_to spin.user.name, admin_user_path(spin.user)
     end
    column "Creation Date", :created_at
    column "Last Update Date", :updated_at
    column "# of reports" do |spin|
        spin.reports.count
    end
    default_actions
  end

  form do |f|
      f.inputs "Details" do
        f.input :content
      end
      f.actions
    end


     show do |spin|
      attributes_table do
        row :id
        row :user
        row :content
        row :image do
          image_tag(spin.multimedia.url(:thumb)) if spin.type?
        end
        panel "Reports" do
          table_for spin.reports do |t|  
            t.column("Id") { |report| report.id }
            t.column("Content") { |report| report.content }
            t.column("Reported by") { |report| report.user.name }
          end
        end
      end
    end

  end