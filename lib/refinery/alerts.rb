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

      def live_alert(*args)
        ::Refinery::Alerts::Alert.live_alert(*args)
      end

      def alert_types
        @alert_types ||= [
          ['Normal', ''],
          ['Critical', 'critical']
        ]
      end
    end
  end
end
