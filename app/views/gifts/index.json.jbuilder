json.gifts do |json|
  json.array! @gifts, partial: 'gifts/gift', as: :gift
end

json.gifts_count @gifts_count
