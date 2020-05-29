require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe 'Products', type: :system do

  before(:each) do
    @product = create(:product)
  end

  describe 'listing page' do

    it 'shows the correct title' do
      visit products_path
      expect(page).to have_content('My 1 product')
    end

    it 'shows a carousel of product pictures' do
      visit products_path
      expect(page).to have_selector('.product-slider .image')
    end

    it 'shows six products when visted' do
      create_list(:product, 5)
      visit products_path
      expect(page).to have_selector('.products-list .product', count: 6)
    end

    it 'shows the correct link on a product' do
      visit products_path
      expect(page).to have_link(@product.title, :href => product_show_path(@product.slug))
    end

    it 'goes to the correct product page when clicked' do
      visit products_path
      expect(page).to have_link(@product.title, :href => product_show_path(@product.slug))
      find('.products-list .product').click
      url = URI.parse(current_url)
      expect(page).to have_current_path(product_show_path(@product.slug))
      expect(find('.product-content .title h2')).to have_content(@product.title)
    end

    it 'shows pagination links when more than 10 products are available' do
      create_list(:product, 11)
      visit products_path
      expect(page).to have_selector('.products-list .product', count: 10)
      expect(page).to have_selector('.pagination', count: 1)
      expect(page).to have_link('Next', :href => products_path({ page: 1 }))
    end

    it 'should go to the next set of products when a pagination link is clicked' do
      create_list(:product, 11)
      visit products_path
      find('.pagination a').click
      expect(page).to have_selector('.products-list .product', count: 2)
    end

    it 'shows a filter drop down of product types' do
      visit products_path
      expect(page).to have_selector('.product-filters .select-box', count: 1)
      expect(find('.product-filters .select-box .select-box__input-text')).to have_content('Filter by Product type')
    end

    it 'shows all the product types when the drop down is clicked' do
      visit products_path
      find('.product-filters .select-box').click
      expect(find('.product-filters .select-box .select-box__list')).to have_content('All')
      expect(find('.product-filters .select-box .select-box__list')).to have_content('Print')
      expect(find('.product-filters .select-box .select-box__list')).to have_content('Class')
    end

    it 'filters the products shown by the product type listed' do
      create_list(:product, 5, :product_type_class)
      visit products_path
      expect(page).to have_selector('.products-list .product', count: 6)
      find('.product-filters .select-box').click
      find('.product-filters .select-box__list li label', text: 'Print').click
      url = URI.parse(current_url)
      expect(page).to have_current_path(products_path({ type: 'print' }))
      expect(page).to have_selector('.products-list .product', count: 1)
    end
    
  end
end