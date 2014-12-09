json.(@user, :name, :email, :gravatar_url, :title, :created_at, :updated_at)

json.statuses do
  json.array! @user.statuses do |status|
    json.extract! status, :description, :created_at
  end
end
