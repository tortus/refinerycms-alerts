module Refinery
  module Alerts
    class Alert < Refinery::Core::BaseModel
      self.table_name = 'refinery_alerts'

      attr_accessible :title, :content, :live_at, :down_at, :position

      acts_as_indexed :fields => [:title, :content]

      validates :title, :presence => true, :uniqueness => true
      validates :live_at, :presence => true

      after_save :invalidate_live_alert, :if => lambda { changed? }

      def live?
        self.id == self.class.live_alert.id
      end

      def self.live
        where('live_at <= :now AND (down_at IS NULL OR :now < down_at)', :now => Time.now)
      end

      def self.ordered
        order('live_at DESC, down_at DESC')
      end

      # This needs to be cached or #live? has n+1 queries
      def self.live_alert(reload = false)
        invalidate_live_alert if reload
        Rails.cache.fetch('refinery.alerts.live_alert') { live.ordered.first }
      end

      def self.invalidate_live_alert
        Rails.cache.delete('refinery.alerts.live_alert')
      end

    end
  end
end
