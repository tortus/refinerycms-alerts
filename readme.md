# Alerts extension for Refinery CMS.

Useful for sites that need to have alert banners go up and come down
at certain times.

## How to build this extension as a gem

    cd vendor/extensions/alerts
    gem build refinerycms-alerts.gemspec
    gem install refinerycms-alerts.gem

    # Sign up for a http://rubygems.org/ account and publish the gem
    gem push refinerycms-alerts.gem