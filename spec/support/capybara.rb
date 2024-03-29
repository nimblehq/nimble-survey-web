# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'

# Give CI some extra time
CAPYBARA_TIMEOUT = ENV['CI'] ? 60 : 30

# https://github.com/rails/rails/pull/30876
Capybara.register_driver(:headless_chrome) do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  # Sets default window size in case the smaller default size is not enough
  options.add_argument('window-size=1440,1440')

  # Chrome won't work properly in a Docker container in sandbox mode
  # Because the user namespace is not enabled in the container by default
  options.add_argument('no-sandbox')

  # Disable GPU usage
  # https://thoughtbot.com/blog/headless-feature-specs-with-chrome#capybara-configuration
  options.add_argument('disable-gpu')

  # Run headless by default unless CHROME_HEADLESS specified
  options.add_argument('headless') unless ENV.fetch('CHROME_HEADLESS', nil) =~ /^(false|no|0)$/i

  # Disable /dev/shm use in CI
  options.add_argument('disable-dev-shm-usage') if ENV['CI']

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.javascript_driver = :chrome
Capybara.default_max_wait_time = CAPYBARA_TIMEOUT
