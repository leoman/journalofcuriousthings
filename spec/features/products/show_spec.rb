require 'rails_helper'
require 'database_cleaner/active_record'
require 'money'

Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_UP
   

RSpec.describe 'Products', type: :system do

  before(:each) do
    @product = create(:product)
  end

  describe 'view page' do

    it 'shows the correct title' do
      visit product_show_path({ slug: @product.slug })
      expect(page).to have_content('My 1 product')
    end

    it 'shows the main image' do
      visit product_show_path({ slug: @product.slug })
      expect(page).to have_selector('.product-images img')
      expect(page.find('.product-images img')['src']).to have_content "post-1.jpg"
    end

    it 'shows the products price' do
      visit product_show_path({ slug: @product.slug })
      expect(page.find('.product .product-content .price').text).to have_content(Money.new(@product.price_cents, 'GBP').format)
    end

    it 'shows the products description' do
      visit product_show_path({ slug: @product.slug })
      expect(page.find('.product .product-content .description')).to have_content @product.description
    end

    it 'shows the purchase button' do
      visit product_show_path({ slug: @product.slug })
      expect(page.find('.product .add-to-cart')).to have_content('Purchase Product')
      expect(page.find('.product .add-to-cart')).to have_link('Purchase Product', :href => orders_details_path(@product.slug))
    end
    
  end
end