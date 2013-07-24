puts "CREATE COMMUNITIES"
%W[ Doctor Lawyer Actor Mechanic Entrepreneur ].each do |name|
  slug = name.downcase.parameterize
  Community.create(name: name, slug: slug, hashtag: "##{slug}", type: "Profession")
end

Community.create(name: "New York", slug: "new-york", hashtag: "#new-york", description:"New York, New York, United States", type: "City")
Community.create(name: "Los Angeles", slug: "los-angeles", hashtag: "#los-angeles", description:"Los Angeles, California, United States", type: "City")
Community.create(name: "Chicago", slug: "chicago", hashtag: "#chicago", description:"Chicago, Illinois, United States", type: "City")
Community.create(name: "Houston", slug: "houston", hashtag: "#houston", description:"Houston, Texas, United States", type: "City")
Community.create(name: "Philadelphia", slug: "philadelphia", hashtag: "#philadelphia", description:"Philadelphia, Pennsylvania, United States", type: "City")

# %W[ #{'New York'} #{'Los Angeles'} Chicago Houston Philadelphia Phoenix #{'San Antonio'}
#   #{'San Diego'} Dallas #{'San Jose'} Austin Jacksonville Indianapolis #{'San Francisco'}
#   Columbus Miami ].each do |name|
#   slug = name.downcase.parameterize
#   Community.create(name: name, slug: slug, hashtag: "##{slug}", type: "City")
# end

puts "CREATE USERS"
20.times do
  user = User.create(
    email: Faker::Internet.email,
    password: Devise.friendly_token.first(8),
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    image: "http://graph.facebook.com/#{rand(300000..302715)}/picture?type=normal",
    communities: Community.all.sample(rand(2..8))
  )
  5.times do
    user.posts.create(
      content: Faker::HipsterIpsum.words(rand(1..50)).join(" ")[0..140],
      communities: Community.all.sample(rand(2..5)),
      approved: rand(1..2).odd? ? true : false
    )
  end
end