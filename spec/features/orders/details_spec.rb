require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe 'Orders', type: :system do

  before(:each) do
    @product = create(:product)
  end

  describe 'details page' do

    it 'shows the 404 page when sent to a product not found' do
      @product = create(:product, :status_draft)
      visit orders_details_path(@product.slug)
      expect(page).to have_content('Page not found')
    end

    it 'shows the checkout steps' do
      visit orders_details_path(@product.slug)
      expect(page).to have_selector('.content .progress', count: 1)
    end

    it 'is on the register details step' do
      visit orders_details_path(@product.slug)
      expect(page).to have_selector('.progress #step0.is-active', count: 1)
    end

    it 'shows a registation form for name and email' do
      visit orders_details_path(@product.slug)
      expect(page).to have_selector('.content form input[name="order[name]"', count: 1)
      expect(page).to have_selector('.content form input[name="order[email]"', count: 1)
    end

    it 'shows a submit button' do
      visit orders_details_path(@product.slug)
      expect(page).to have_selector('.content form input[type="submit"]', count: 1)
      expect(page.find('.content form input[type="submit"]').value).to have_content('Submit')
    end

    it 'shows validation errors for name and email when the submit is clicked' do
      visit orders_details_path(@product.slug)
      page.find('.content form input[type="submit"]').click
      expect(page.find(:css,'.content form .input-wrapper', match: :first).find('.error_explanation')).to have_content("Name can\'t be blank")
      expect(page.find(:css,'.content form .input-wrapper', match: :first).find('.error_explanation')).to have_content("Name is too short (minimum is 1 character)")
      expect(page.find(".content form > div:nth-child(3)").find('.error_explanation')).to have_content("Email is invalid")
    end

    # it 'shows summary of the product' do

    # end

    # it 'moves to the checkout page when the form is filled in correctly' do

    # end

    # it 'saves a new pending order to the DB when the submit is clicked' do
      
    # end
    
  end
end