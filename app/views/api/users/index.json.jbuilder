json.array! @users do |user|
  json.extract! user, :id, :name, :gravatar_url

  json.latest_status do
    if user.statuses.empty?
      json.null!
    else
      json.extract! user.statuses.latest, :description, :created_at
    end
  end
end
