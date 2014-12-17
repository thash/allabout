require 'bundler/setup'
Bundler.require

Capybara.javascript_driver = :webkit
s = Capybara::Session.new(:webkit)

s.visit 'https://projecteuler.net/about'
s.click_link 'Sign In'

binding.pry
