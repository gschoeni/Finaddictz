if(Role.count == 0)
  puts 'creating roles'
  {'admin' => 'Admin', 'guide' => 'Guide', 'angler' => 'Angler', 'property_owner' => 'Property Owner'}.each do |key, val|
    Role.create(
      name: key,
      readable_name:val
    )
  end
else 
  puts 'roles already seeded'
end


if(User.count == 0)
  puts 'creating users'
  u = User.create(
    first_name: 'Greg',
    last_name: 'Schoeninger',
    password: 'password',
    password_confirmation: 'password',
    email: 'greg.schoeninger@gmail.com',
    active_role: 'admin',
    confirmed: true
  )
  GuideExt.create({:about => "Edit profile to change your guide about section..", :experience => 'Novice', :user_id => u.id})
  AnglerExt.create({:about => "Edit profile to change your angler about section..", :experience => 'Novice', :user_id => u.id})
  PropExt.create({:about => "Edit profile to change your property_owner about section..", :user_id => u.id})
  u.roles << Role.find_by_name("admin")
  u.roles << Role.find_by_name("guide")
  u.roles << Role.find_by_name("property_owner")
  u.save

  u = User.create(
    first_name: 'Steve',
    last_name: 'Lynch',
    password: 'password',
    password_confirmation: 'password',
    email: 'slynch00@gmail.com',
    active_role: 'admin',
    confirmed: true
  )
  GuideExt.create({:about => "Edit profile to change your guide about section..", :experience => 'Novice', :user_id => u.id})
  AnglerExt.create({:about => "Edit profile to change your angler about section..", :experience => 'Novice', :user_id => u.id})
  PropExt.create({:about => "Edit profile to change your property_owner about section..", :user_id => u.id})
  u.roles << Role.find_by_name("admin")
  u.roles << Role.find_by_name("guide")
  u.roles << Role.find_by_name("property_owner")
  u.save

  u = User.create(
    first_name: 'Ryan',
    last_name: 'Guest',
    password: 'password',
    password_confirmation: 'password',
    email: 'guest.ryan@gmail.com',
    active_role: 'admin',
    confirmed: true
  )
  GuideExt.create({:about => "Edit profile to change your guide about section..", :experience => 'Novice', :user_id => u.id})
  AnglerExt.create({:about => "Edit profile to change your angler about section..", :experience => 'Novice', :user_id => u.id})
  PropExt.create({:about => "Edit profile to change your property_owner about section..", :user_id => u.id})
  u.roles << Role.find_by_name("admin")
  u.roles << Role.find_by_name("guide")
  u.roles << Role.find_by_name("property_owner")
  u.save

  u = User.create(
    first_name: 'Angus',
    last_name: 'Angler',
    password: 'password',
    password_confirmation: 'password',
    email: 'angus.angler@gmail.com',
    active_role: 'angler',
    confirmed: true
  )
  GuideExt.create({:about => "Edit profile to change your guide about section..", :experience => 'Novice', :user_id => u.id})
  AnglerExt.create({:about => "Edit profile to change your angler about section..", :experience => 'Novice', :user_id => u.id})
  PropExt.create({:about => "Edit profile to change your property_owner about section..", :user_id => u.id})
  u.save

  u = User.create(
    first_name: 'Gerry',
    last_name: 'Guide',
    password: 'password',
    password_confirmation: 'password',
    email: 'gerry.guide@gmail.com',
    active_role: 'guide',
    confirmed: true
  )
  GuideExt.create({:about => "Edit profile to change your guide about section..", :experience => 'Novice', :user_id => u.id})
  AnglerExt.create({:about => "Edit profile to change your angler about section..", :experience => 'Novice', :user_id => u.id})
  PropExt.create({:about => "Edit profile to change your property_owner about section..", :user_id => u.id})
  u.roles << Role.find_by_name('guide')
  u.save


  u = User.create(
    first_name: 'Peter',
    last_name: 'Property-Owner',
    password: 'password',
    password_confirmation: 'password',
    email: 'peter.property-owner@gmail.com',
    active_role: 'property_owner',
    confirmed: true
  )
  GuideExt.create({:about => "Edit profile to change your guide about section..", :experience => 'Novice', :user_id => u.id})
  AnglerExt.create({:about => "Edit profile to change your angler about section..", :experience => 'Novice', :user_id => u.id})
  PropExt.create({:about => "Edit profile to change your property_owner about section..", :user_id => u.id})
  u.roles << Role.find_by_name('property_owner')
  u.save

else
  puts 'users already seeded'
end


if GuidePost.count < 50
  puts 'seeding guide posts'
  times = ['Morning', 'Mid-Morning', 'Afternoon', 'Late Afternoon']
  adjectives = ['Fun', 'Joyous', 'Action packed', 'Exciting', 'Wild']
  wants = ['Want', 'Need', 'Would like', 'Inquiring about']
  50.times do |i|
    GuidePost.create(
      user_id: (i%6),
      description: "#{adjectives[i%5]} fishing tour!", 
      num_people: (i%4+1), 
      price_per: 100*(i%4+1), 
      date: Time.mktime(2012, 8, i%29+1), 
      time: times[i%4], 
      status: nil,
      title: "#{wants[i%4]} #{i%4} people to go fishing with."
    )
  end
else 
  puts 'already some guide posts in the db'
end


if AnglerPost.count < 50
  puts 'seeding angler posts'
  times = ['Morning', 'Mid-Morning', 'Afternoon', 'Late Afternoon']
  people = ['buddy', 'friend', 'pal', 'gal', 'guy']
  wants = ['Want', 'Need', 'Would like', 'Inquiring about']
  50.times do |i|
    AnglerPost.create(
      user_id:i%6,
      num_people: i%4+1, 
      price_min: 10*(i%6+1), 
      price_max: 20*(i%6+1), 
      date: Time.mktime(2012, 8, i%29+1), 
      time: times[i%4], 
      description: "#{wants[i%4]} to go fishing with a #{people[i%5]}, let me know if you interested", 
      search_guide: false, 
      search_angler: true, 
      created_at: "2012-08-19 15:19:22", 
      updated_at: "2012-08-19 15:19:22", 
      title: "#{wants[i%4]} Fishing Trip"
    )
  end

else 
  puts 'already some angler posts in the db'
end


