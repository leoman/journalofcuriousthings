include ActionDispatch::TestProcess

post = {
  title: "My first blog post",
  subtitle: 'An amazing subtitle',
  excerpt: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
  content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
  status: :published,
  sticky: true,
  date: Date.today,
}

posts = [
    {
        **post
    },
    {
      title: "My second blog post",
        **post
    }
]



FactoryBot.define do

  # posts.each do |post|

    factory :post do

      sequence(:title) { |n| "My #{n} blog post" }
      subtitle { post[:subtitle] }
      excerpt { post[:excerpt].truncate(50) }
      content { post[:content] }
      sticky { post[:sticky] }
      date { post[:date] }
      status { post[:status] }

      # mainImage { Rack::Test::UploadedFile.new('path', 'image/png') }
      mainImage { fixture_file_upload("#{Rails.root}/spec/files/post-1.jpg")  }

      trait :published do
        status { :published }
      end

      trait :unpublished do
        status { :unpublished }
      end
    end
  # end
  # factory :post_image_file do
  #   association :post, factory: :post
  #   activity_type {:cycling}
  #   original_activity_log_file { fixture_file_upload("#{Rails.root}/spec/files/example_fit_file.fit") }
  # end

end