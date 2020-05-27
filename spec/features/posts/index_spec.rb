require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe 'Posts', type: :system do

  # before(:all) do
  #   # Selenium::WebDriver.logger.level = :debug
  #   Capybara.current_driver = :headless_chrome
  #   Capybara.javascript_driver = :headless_chrome
  # end

  # describe Post do
  #   before(:all) do
  #     Rails.application.load_seed
  #     # create_list :post, 2
  #   end
  # end

  before(:all) do
    # DatabaseCleaner.clean
    # create :post
  end

  describe 'index page' do
    it 'shows six posts' do
      create_list(:post, 6)
      visit posts_path
      # byebug
      expect(page).to have_selector('#gridView .item', count: 6)
      expect(page).to have_content('My 1 blog post')
    end
  end
end