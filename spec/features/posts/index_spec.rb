require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe 'Posts', type: :system do

  before(:each) do
    @post = create(:post)
  end

  describe 'listing page' do

    it 'shows the correct title' do
      visit posts_path
      expect(page).to have_content('My 1 blog post')
    end

    it 'shows six posts when visted' do
      create_list(:post, 5)
      visit posts_path
      expect(page).to have_selector('#gridView .item', count: 6)
    end

    it 'shows the correct link on a post' do
      visit posts_path
      expect(page).to have_link(@post.title, :href => post_show_path(@post.slug))
    end

    it 'goes to the correct post page when clicked' do
      visit posts_path
      expect(page).to have_link(@post.title, :href => post_show_path(@post.slug))
      find('#gridView .item').click
      url = URI.parse(current_url)
      expect(page).to have_current_path(post_show_path(@post.slug))
      expect(find('div.title h3')).to have_content(@post.title)
    end

    it 'shows pagination links when more than 10 posts are available' do
      create_list(:post, 11)
      visit posts_path
      expect(page).to have_selector('#gridView .item', count: 10)
      expect(page).to have_selector('.pagination', count: 1)
      expect(page).to have_link('Next', :href => posts_path({ page: 1 }))
    end

    it 'should go to the next set of posts when a pagination link is clicked' do
      create_list(:post, 11)
      visit posts_path
      find('.pagination a').click
      expect(page).to have_selector('#gridView .item', count: 2)
    end
    
  end
end