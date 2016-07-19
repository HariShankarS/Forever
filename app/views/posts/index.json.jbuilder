json.array!(@posts) do |post|
  json.extract! post, :id, :body, :name, :photo
  json.url post_url(post, format: :json)
end
