json.data do
  json.array! @ideas do |idea|
    json.id idea.id
    json.category idea.category_name
    json.body idea.body
  end
end
