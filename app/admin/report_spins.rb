ActiveAdmin.register ReportSpin , :as => "Reported Spins" do
  menu :parent => 'Report'

   	index do
    column :id
    column :content
    column "Reported by" do |report|
        link_to report.user.name, admin_user_path(report.user)
    end
    column "Reported Spin" do |report|
        link_to report.spin.id, admin_spin_path(report.spin)
    end
    default_actions
  end

  show do |report|
      attributes_table do
        row :id
        row ("Reported By") { |report| link_to report.user.name, admin_user_path(report.user) }
        row :content
        row ("Reported Spin") { |report| link_to report.spin.id, admin_spin_path(report.spin) }
        row :created_at
        row :updated_at
      end
    end
end
