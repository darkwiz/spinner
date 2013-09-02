ActiveAdmin.register Comment do

	index do
		column :id
		column :body
		column :spin do |comment|
			link_to comment.spin.id, admin_spin_path(comment.spin)
		end
		column "Author" do |comment|
			link_to comment.user.name, admin_user_path(comment.user)
		end
		column "# of reports" do |comment|
			comment.reports.count
		end
		column :created_at
		default_actions
	end

	form do |f|
		f.inputs "Details" do
			f.input :body
		end
		f.actions
	end
	
	show do |comment|
		attributes_table do
			row :id
			row :body
			panel "Reports" do
				table_for comment.reports do |t|  
					t.column("Id") { |report| report.id }
					t.column("Content") { |report| report.content }
					t.column("Reported by") { |report| report.user.name }
				end
			end
		end
	end
end