json.extract! user, :id, :name, :age, :country, :gender, :email, :password :created_at, :updated_at
json.url user_url(user, format: :json)
