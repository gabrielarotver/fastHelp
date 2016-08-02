json.extract! event, :id, :organization_id, :event_name, :date, :time, :street_address, :city, :state, :zip_code, :created_at, :updated_at
json.url event_url(event, format: :json)