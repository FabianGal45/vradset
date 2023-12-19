json.extract! advertisement, :id, :title, :description, :url, :created_at, :updated_at
json.url advertisement_url(advertisement, format: :json)
