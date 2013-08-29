ActiveAdmin.register User do
scope :public

index do
	column :id
    column :username
    column :name
    column :email
    column :confirmed_user
    column :private
    column "Sign Up Date", :created_at
    default_actions
  end

#  View del singolo utente (di default ci sono i suoi dati)
#  show do
#   panel "Spins" do
#     table_for user.spins do |t|  
#       t.column("Content") { |spin| spin.content }
#     end
#   end
# end
end
