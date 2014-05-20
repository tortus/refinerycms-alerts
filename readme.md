# Alerts extension for Refinery CMS.

Useful for sites that need to have alert banners go up and come down
at certain times.

## Usage

```ruby
# app/decorators/controllers/refinery/pages_controller_decorator.rb
Refinery::PagesController.class_eval do
  before_filter :set_alert, :if => lambda { home_page? }
private
  def set_alert
    @alert = ::Refinery::Alerts.live_alert
  end
end
```

```erb
# app/views/refinery/pages/home.html.erb
<% if @alert.present? %>
  <h2><%= @alert.title %></h2>
  <%= raw @alert.content %>
<% end %>
```

## How to build this extension as a gem

    cd vendor/extensions/alerts
    gem build refinerycms-alerts.gemspec
    gem install refinerycms-alerts.gem

    # Sign up for a http://rubygems.org/ account and publish the gem
    gem push refinerycms-alerts.gem
