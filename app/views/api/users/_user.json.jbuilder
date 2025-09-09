json.extract! user, :id, :name, :email
json.avatar_url url_for(user.avatar) || nil