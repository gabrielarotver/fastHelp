json.extract! organization, :id, :org_name, :org_type, :contact_name, :contact_number, :street_address, :city, :state, :zip_code, :email, :created_at, :updated_at, :latitude, :longitude, :description
json.url organization_url(organization, format: :json)
