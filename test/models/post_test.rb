require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save Post without title" do
    post = Post.new
    PostTest::add_content(post)
    PostTest::add_a_date(post)
    PostTest::add_a_status(post)
    
    assert_not post.save
  end

  test "should not save Post with a title over 120 charachters" do
    post = Post.new

    PostTest::add_a_title(post, 'This is a really really really really really really really really really really really really really really really really long title')
    PostTest::add_content(post)
    PostTest::add_a_date(post)
    PostTest::add_a_status(post)
    
    assert_not post.save
  end

  test "should not save Post with a non unique title" do
    post = Post.new

    PostTest::add_a_title(post, 'My first blog post')
    PostTest::add_content(post)
    PostTest::add_a_date(post)
    PostTest::add_a_status(post)
    
    assert_not post.save
  end

  test "should not save Post without content" do
    post = Post.new

    PostTest::add_a_title(post)
    PostTest::add_a_date(post)
    PostTest::add_a_status(post)
    
    assert_not post.save
  end

  test "should not save Post without a date" do
    post = Post.new

    PostTest::add_a_title(post)
    PostTest::add_content(post)
    PostTest::add_a_status(post)
    
    assert_not post.save
  end

  test "should not save Post without a status" do
    post = Post.new

    PostTest::add_a_title(post)
    PostTest::add_content(post)
    PostTest::add_a_date(post)
    
    assert_not post.save
  end

  test "status_to_i method should return the correct status" do
    assert_equal 0, Post::status_to_i('published')
    assert_equal 1, Post::status_to_i('unpublished')
  end

  test "STATUS_PUBLISHED const should return the published status" do
    assert_equal 'published', Post::STATUS_PUBLISHED
  end
  
  private

    def self.add_a_title(model, content = 'Title')
      model.title = content
    end

    def self.add_content(model)
      model.content = 'Content'
    end

    def self.add_a_date(model)
      model.date = Date.today
    end

    def self.add_a_status(model)
      model.status = Post::STATUS_PUBLISHED
    end

end
