FactoryBot.define do
  factory :photo do
    association :user 
    sequence(:title)  { |n| "testphoto_#{n}" }
    image_file  { Rack::Test::UploadedFile.new('spec/fixtures/test_image.jpg', 'image/jpeg') }
  end
end