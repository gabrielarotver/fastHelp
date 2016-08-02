class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :org_name
      t.string :org_type
      t.string :contact_name
      t.string :contact_number
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
