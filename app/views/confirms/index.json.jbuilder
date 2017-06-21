json.helpers do |json|
  json.array! @helpers, partial: 'profiles/profile', as: :user
end

json.helpers_count @helpers_count
