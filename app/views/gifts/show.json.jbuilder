json.gift do |json|
  json.partial! 'gifts/gift', gift: @gift
end
