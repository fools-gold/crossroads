json.array!(@hashtags) do |hashtag|
  json.extract! hashtag, :id, :name
  json.url hashtag_url(hashtag, format: :json)
end
