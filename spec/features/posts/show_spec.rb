require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe 'Posts', type: :system do

  before(:each) do
    @post = create(:post)
  end

  describe 'view page' do

    it 'shows the correct title' do
      visit post_show_path({ slug: @post.slug })
      expect(page).to have_content('My 1 blog post')
    end

    it 'shows the main image' do
      visit post_show_path({ slug: @post.slug })
      expect(page).to have_selector('.post-block .image img')
      expect(page.find('.post-block .image img')['src']).to have_content "post-1.jpg"
    end

    it 'shows the page contents' do
      visit post_show_path({ slug: @post.slug })
      expect(page.find('.post-block .post-content')).to have_content @post.content
    end

    it 'shows the about me aside' do
      visit post_show_path({ slug: @post.slug })
      expect(page.find('.sidebar .about')).to have_content('about me')
      expect(page).to have_selector('.sidebar .about img')
    end
    
  end
end