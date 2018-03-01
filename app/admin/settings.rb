ActiveAdmin.register_page "Settings" do
  content do
    render partial: 'settings'
  end

  page_action :clear_cache, method: :get do
    Rails.cache.clear
    redirect_to admin_settings_path, notice: "Cache was cleared"
  end
end
