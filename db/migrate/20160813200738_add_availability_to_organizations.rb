class AddAvailabilityToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :availability, :boolean
  end
end
