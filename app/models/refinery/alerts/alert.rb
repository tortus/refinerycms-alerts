module Refinery
  module Alerts
    class Alert < Refinery::Core::BaseModel
      self.table_name = 'refinery_alerts'

      attr_accessible :title, :alert_type, :content, :live_at, :down_at, :position

      acts_as_indexed :fields => [:title, :content]

      validates :title, :presence => true, :uniqueness => true
      validates :live_at, :presence => true

      after_save :invalidate_live_alert
      after_destroy :invalidate_live_alert

      def live?
        now = Time.zone.now
        live_at <= now && (down_at.blank? || now < down_at)
      end

      def self.live
        where('live_at <= :now AND (down_at IS NULL OR :now < down_at)', :now => Time.zone.now)
      end

      def self.ordered
        order('live_at DESC, down_at DESC')
      end

      def self.live_alert(reload = false)
        invalidate_live_alert if reload
        alert = Rails.cache.fetch('refinery.alerts.live_alert') { live.ordered.first }
        if alert && !alert.live?
          invalidate_live_alert
          nil
        else
          alert
        end
      end

      def self.invalidate_live_alert
        Rails.cache.delete('refinery.alerts.live_alert')
      end

      private

        def invalidate_live_alert
          self.class.invalidate_live_alert
        end

    end
  end
end
