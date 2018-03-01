if current_user.errors.count == 0
  json.location "#{restaurateurs_path}"
else
  json.errors current_user.errors.full_messages
  json.errors_html render partial: 'shared/form_errors', locals: { errors: current_user.errors.full_messages }
end

