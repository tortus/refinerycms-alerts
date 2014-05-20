module Refinery
  module Alerts
    class AlertsController < ::ApplicationController

      before_filter :find_all_alerts
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @alert in the line below:
        present(@page)
      end

      def show
        @alert = Alert.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @alert in the line below:
        present(@page)
      end

    protected

      def find_all_alerts
        @alerts = Alert.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/alerts").first
      end

    end
  end
end
