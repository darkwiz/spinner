ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }
  content :title => proc{ I18n.t("active_admin.dashboard") } do

    section "Recent Spins" do
     table_for Spin.order("created_at desc").limit(5) do
      column :content do |spin|
        link_to spin.content, admin_spin_path(spin)
      end
      column :created_at
    end
    strong { link_to "View all spins", admin_spins_path }
  end

  #  Here is an example of a simple dashboard with columns and panels.
    
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
