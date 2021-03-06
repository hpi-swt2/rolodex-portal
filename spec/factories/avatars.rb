FactoryBot.define do
  factory :avatar do
    file { 'some binary content that is too big for tests' }
    filename { 'default_avatar.png' }
    file_size { 2.megabytes }
    mime_type { 'image/png' }
    association :user, strategy: :build
  end
end
