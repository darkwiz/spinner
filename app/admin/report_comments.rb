ActiveAdmin.register ReportComment, :as => "Reported Comments" do
  menu :parent => 'Report'

  index do
    column :id
    column :content
    column "Reported By" do |report|
        link_to report.user.name, admin_user_path(report.user)
    end
    column "Reported Comment" do |report|
        link_to report.comment.id, admin_comment_path(report.comment)
    end
    default_actions
  end

 show do |report|
      attributes_table do
        row :id
        row ("Reported By") { |report| link_to report.user.name, admin_user_path(report.user) }
        row :content
        row ("Reported Comment") { |report| link_to report.comment.id, admin_comment_path(report.comment) }
        row :created_at
        row :updated_at
      end
    end
end
