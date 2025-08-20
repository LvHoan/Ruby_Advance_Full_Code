json.partial! 'api/shared/standard_response'

json.lessons @lessons do |lesson|
  json.extract! lesson, :id, :title, :context
end