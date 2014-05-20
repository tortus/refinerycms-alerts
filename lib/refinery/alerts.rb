require 'refinerycms-core'

module Refinery
  autoload :AlertsGenerator, 'generators/refinery/alerts_generator'

  module Alerts
    require 'refinery/alerts/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end

      def live_alert(reload = false)
        remove_instance_variable(:@live_alert) if reload
        unless defined?(@live_alert)
          @live_alert = ::Refinery::Alerts::Alert.live.ordered.first
        end
        @live_alert
      end
    end
  end
end
