module Refinery
  module Alerts
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Alerts

      engine_name :refinery_alerts

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "alerts"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.alerts_admin_alerts_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/alerts/alert'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Alerts)
      end
    end
  end
end
