if @result
  json.address @result[:address]
  json.location restaurants_path
else
  json.error I18n.t 'location.cant_set'
end
