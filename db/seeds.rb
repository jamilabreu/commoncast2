puts "CREATE COMMUNITIES"
%W[ Doctor Lawyer Actor Mechanic Entrepreneur ].each do |name|
  slug = name.downcase.parameterize
  Community.create(name: name, slug: slug, hashtag: "##{slug}", type: "Profession")
end

%W[ #{'New York'} #{'Los Angeles'} Chicago Houston Philadelphia Phoenix #{'San Antonio'}
  #{'San Diego'} Dallas #{'San Jose'} Austin Jacksonville Indianapolis #{'San Francisco'}
  Columbus Miami ].each do |name|
  slug = name.downcase.parameterize
  Community.create(name: name, slug: slug, hashtag: "##{slug}", type: "City")
end

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