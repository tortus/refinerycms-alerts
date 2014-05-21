module Refinery
  module Alerts
    class Alert < Refinery::Core::BaseModel
      self.table_name = 'refinery_alerts'

      attr_accessible :title, :content, :live_at, :down_at, :position

      acts_as_indexed :fields => [:title, :content]

      validates :title, :presence => true, :uniqueness => true
      validates :live_at, :presence => true

      after_save :invalidate_live_alert

      def live?
        self.id == ::Refinery::Alerts.live_alert.id
      end

      def self.live
        where('live_at <= :now AND (down_at IS NULL OR :now < down_at)', :now => Time.now)
      end

      def self.ordered
        order('live_at DESC, down_at DESC')
      end

      private

        def invalidate_live_alert
          if changed?
            ::Refinery::Alerts.invalidate_live_alert
          end
        end

    end
  end
end
