class AddAlertTypeToAlertsAlerts < ActiveRecord::Migration

  def change
    add_column :refinery_alerts, :alert_type, :string
  end

end
