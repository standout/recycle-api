json.array!(@admins) do |admin|
  json.extract! admin, :id, :name, :secret
  json.url admin_url(admin, format: :json)
end
