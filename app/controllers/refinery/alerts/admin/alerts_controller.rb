module Refinery
  module Alerts
    module Admin
      class AlertsController < ::Refinery::AdminController

        crudify :'refinery/alerts/alert',
                :xhr_paging => true

      end
    end
  end
end
