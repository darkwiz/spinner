ActiveAdmin.register_page "Dashboard" do

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent Reported Comments" do
          table_for ReportComment.where('created_at < ? and created_at > ?', Time.now, 6.week.ago) do |r|
           column :id
           r.column("Reported by") { |report| link_to report.user.name , [:admin, report.user] }
           r.column("Reported Comment") { |report| link_to report.comment.id, [:admin, report.comment] }

         end
        end
      end

      column do
       panel "Recent Reported Spins" do
        table_for ReportSpin.where('created_at < ? and created_at > ?', Time.now, 6.week.ago) do |r|
         column :id
         r.column("Reported by") { |report| link_to report.user.name , [:admin, report.user] }
         r.column("Reported Spin") { |report| link_to report.spin.id, [:admin, report.spin] }

         end
        end
      end

      column do
       panel "Recent Reported Users" do
        table_for ReportUser.where('created_at < ? and created_at > ?', Time.now, 6.week.ago) do |r|
         column :id
         r.column("Reported by") { |report| link_to report.reported_by.name , [:admin, report.reported_by] }
         r.column("Reported User") { |report| link_to report.user.name, [:admin, report.user] }
         r.column("Reported User Status") { |report| status_tag (report.user.banned ? "Banned" : "Active"), (report.user.banned ? :error : :ok) }
       end
        end
      end

    end # columns

    # Define your dashboard sections here. Each block will be
    # rendered on the dashboard in the context of the view. So just
    # return the content which you would like to display.
    
    # The dashboard is organized in rows and columns, where each row
    # divides the space for its child columns equally.

    # To start a new row, open a new 'columns' block, and to start a
    # new column, open a new 'colum' block. That way, you can exactly
    # define the position for each content div.

    # == Simple Dashboard Column
    # Here is an example of a simple dashboard column
    #
    # column do
    # panel "Recent Posts" do
    # content_tag :ul do
    # Post.recent(5).collect do |post|
    # content_tag(:li, link_to(post.title, admin_post_path(post)))
    # end.join.html_safe
    # end
    # end
    # end
    
    # == Render Partials
    # The block is rendererd within the context of the view, so you can
    # easily render a partial rather than build content in ruby.
    #
    # column do
    # panel "Recent Posts" do
    # render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
    # end
    # end

  end # content
end