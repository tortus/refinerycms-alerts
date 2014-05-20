module Refinery
  module Alerts
    module Admin
      class AlertsController < ::Refinery::AdminController

        crudify :'refinery/alerts/alert',
                :xhr_paging => true,
                :order => 'live_at DESC, down_at DESC'

      end
    end
  end
end
