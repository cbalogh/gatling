require 'capybara'
require 'capybara/dsl'
require 'gatling'
require 'matchers/look_like_matcher'

Capybara.default_driver = :selenium
Capybara.app_host = 'http://www.google.com'


