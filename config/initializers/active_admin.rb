ActiveAdmin.setup do |config|
  config.site_title = "Foodery"
  config.batch_actions = true
  config.localize_format = :long
  config.authentication_method = :authenticate_active_admin_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.comments = false
  config.register_stylesheet 'base/pages/_active_admin'
  config.prepend_before_action -> { Time.zone = 'Eastern Time (US & Canada)' }

  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: "Menus (EN)", url: '/admin/menus?locale=en', priority: 4
      menu.add label: "Restaurants (EN)", url: '/admin/restaurants?locale=en', priority: 4
    end
  end
end
