module Refinery
  module Alerts
    class Alert < Refinery::Core::BaseModel
      self.table_name = 'refinery_alerts'

      attr_accessible :title, :content, :live_at, :down_at, :position

      validates :title, :presence => true, :uniqueness => true

      def live?
        now = Time.now
        (live_at.present? && live_at <= now) && (down_at.blank? || now < down_at)
      end

      def self.live
        where('live_at <= :now AND :now < down_at', now: Time.now)
      end

      def self.live_alert
        live.order('live_at DESC').first
      end

    end
  end
end
