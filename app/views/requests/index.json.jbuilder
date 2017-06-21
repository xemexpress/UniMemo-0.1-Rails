json.requests do |json|
  json.array! @requests, partial: 'requests/request', as: :request
end

json.requests_count @requests_count
