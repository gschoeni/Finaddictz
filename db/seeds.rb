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




if River.count == 0
  puts 'seeding rivers'
  River.create(
    latitude:37.25459609821637,
    longitude:-107.87436748398437,
    address:"Animas River",
    city:"",
    state:"Colorado",
    country:"USA"
  )

  River.create(
    latitude:39.638420,
    longitude:-106.074300,
    address:"Blue River",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:39.630150,
    longitude:-106.412770,
    address:"Colorado River",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:39.378060,
    longitude:-106.930540,
    address:"Frying Pan River",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:39.630150,
    longitude:-106.412770,
    address:"Gore Creek",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:38.556480,
    longitude:-107.678720,
    address:"Gunnison River",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:40.795740,
    longitude:-106.968160,
    address:"North Delaney Lake",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:40.971270,
    longitude:-106.343120,
    address:"North Platte River",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:37.678160,
    longitude:-106.615570,
    address:"Rio Grande",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:39.444110,
    longitude:-107.264560,
    address:"Roaring Fork River",
    city:"",
    state:"Colorado",
    country:"USA"
  )

  River.create(
    latitude:39.236140,
    longitude:-105.254980,
    address:"South Platte River",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:39.001730,
    longitude:-105.692720,
    address:"Spinney Mountain Reservoir",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  River.create(
    latitude:40.795740,
    longitude:-106.968160,
    address:"Steamboat Lake",
    city:"",
    state:"Colorado",
    country:"USA"
  )
  puts '12'
else 
  puts 'rivers already seeded'

end


if BookingStatus.count == 0
  puts 'setting booking statuses'
  BookingStatus.create(
    status:'Booked'
  )

  BookingStatus.create(
    status:'Pending'
  )

  BookingStatus.create(
    status:'Open'
  )
else 
  puts 'Booking statuses set'
end

if GuidePost.count <= 0
  puts 'seeding guide posts'
  times = ['Morning', 'Mid-Morning', 'Afternoon', 'Late Afternoon']
  adjectives = ['Fun', 'Joyous', 'Action packed', 'Exciting', 'Wild']
  wants = ['Want', 'Need', 'Would like', 'Inquiring about']
  50.times do |i|
    river = River.find(i%River.count()+1)
    GuidePost.create(
      user_id: (i%6+1),
      booking_status_id:BookingStatus.find_by_status("Open").id,
      river_id:river.id,
      latitude:river.latitude,
      longitude:river.longitude,
      description: "#{adjectives[i%5]} fishing tour!", 
      num_people: (i%4+1), 
      price_per: 100*(i%4+1), 
      date: "#{Time.now().year}-#{Time.now().month+1}-#{i%Time.now.end_of_month.day+1}", 
      time: times[i%4], 
      status: nil,
      title: "#{wants[i%4]} #{i%4} people to go fishing with.", 
      abusive_flag: "false"
    )
  end
else 
  puts 'already some guide posts in the db'
end


if AnglerPost.count <= 0
  puts 'seeding angler posts'
  times = ['Morning', 'Mid-Morning', 'Afternoon', 'Late Afternoon']
  people = ['buddy', 'friend', 'pal', 'gal', 'guy']
  wants = ['Want', 'Need', 'Would like', 'Inquiring about']
  50.times do |i|
    river = River.find(i%River.count()+1)
    AnglerPost.create(
      user_id:i%6+1,
      booking_status_id:BookingStatus.find_by_status("Open").id,
      river_id:river.id,
      latitude:river.latitude,
      longitude:river.longitude,
      num_people: i%4+1, 
      price_min: 10*(i%6+1), 
      price_max: 20*(i%6+1), 
      date: "#{Time.now().year}-#{Time.now().month+1}-#{i%Time.now.end_of_month.day+1}",
      time: times[i%4], 
      description: "#{wants[i%4]} to go fishing with a #{people[i%5]}, let me know if you interested", 
      search_guide: false, 
      search_angler: true, 
      created_at: "2012-08-19 15:19:22", 
      updated_at: "2012-08-19 15:19:22", 
      title: "#{wants[i%4]} Fishing Trip", 
      abusive_flag: "false"
    )
  end

else 
  puts 'already some angler posts in the db'
end

if PropertyPost.count == 0
  puts 'seeding property posts'
  description = ['This is a really nice spot', 'All by yourself on a stretch of the St. Vrain', 'Big Thompson place', 'This is a private spot that is not fished much anymore']
  people = ['buddy', 'friend', 'pal', 'gal', 'guy']
  wants = ['Offering', 'Sweet', 'Fishing', 'Big time fishing']
  20.times do |i| 
    PropertyPost.create(
      title: "#{wants[i%4]} Property",
      description: "#{description[i%4]}",
      booking_status_id:BookingStatus.find_by_status("Open").id,
      price: "#{i%500}",
      user_id: i%6+1, 
      abusive_flag: "false"
      )
  end
else
  puts 'already seeded property posts'
end

if NotificationType.count == 0
  puts 'setting NotificationTypes'
  NotificationType.create(
    name:'message'
  )

  NotificationType.create(
    name:'trip_booking'
  )

  NotificationType.create(
    name:'trip_full'
  )

  NotificationType.create(
    name:'trip_confirmed'
  )
else 
  puts 'NotificationTypes set'
end

if Page.count == 0
  puts 'setting Pages'
  Page.create(
    name:'Guide Posts'
  )

  Page.create(
    name:'Angler Posts'
  )

  Page.create(
    name:'Trip Detail'
  )

  Page.create(
    name:'Map Page'
  )
else 
  puts 'NotificationTypes set'
end