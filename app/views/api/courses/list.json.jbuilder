json.partial! 'api/shared/standard_response'

json.courses @courses do |course|
  json.extract! course, :id, :title, :description, :image_url
end
