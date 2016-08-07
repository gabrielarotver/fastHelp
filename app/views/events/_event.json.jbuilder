json.extract! event, :id, :organization_id, :time, :street_address, :city, :state, :zip_code, :created_at, :updated_at, :latitude, :longitude
json.title event.event_name
json.start event.date
json.url event_url(event, format: :html)
