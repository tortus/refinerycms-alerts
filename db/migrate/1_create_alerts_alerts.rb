class CreateAlertsAlerts < ActiveRecord::Migration

  def up
    create_table :refinery_alerts do |t|
      t.string :title
      t.text :content
      t.datetime :live_at
      t.datetime :down_at
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-alerts"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/alerts/alerts"})
    end

    drop_table :refinery_alerts

  end

end
