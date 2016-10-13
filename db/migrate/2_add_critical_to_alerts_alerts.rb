class CreateAlertsAlerts < ActiveRecord::Migration

  def change
    add_column :refinery_alerts, :critical, :boolean, :null => false, :default => false
  end

end
