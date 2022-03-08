require 'open-uri'

puts "Destroying all the DBs...!!!"

Waypoint.destroy_all
puts "Waypoint db destroyed"

HotspotWalk.destroy_all
puts "Hotspot_walk db destroyed"

FavoriteWalk.destroy_all
puts "Favorite_walk db destroyed"

Review.destroy_all
puts "Review db destroyed"

Walk.where.not(original_walk_id: nil).destroy_all
Walk.destroy_all
puts "Walk db destroyed"

User.destroy_all
puts "User db destroyed"

Hotspot.destroy_all
puts "Hotspot db destroyed"

puts "All DBs are down ! I repeat, all DBs are down !"

puts "Creating 6 Users"
gala = User.create!(email: 'gala@mail.com', password: 'gala', username: 'gala')
gala.photo.attach(
  io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1645623392/Users/gala_by9udp.jpg'),
  filename: 'gala_by9udp.jpg',
  content_type: 'image/jpg'
)

cedric = User.create!(email: 'cedric@mail.com', password: 'cedric', username: 'cedric')
cedric.photo.attach(
  io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1645623392/Users/cedric_peqsvm.jpg'),
  filename: 'cedric_peqsvm.jpg',
  content_type: 'image/jpg'
)

marion = User.create!(email: 'marion@mail.com', password: 'marion', username: 'marion')
marion.photo.attach(
  io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1645623392/Users/marion2_dpnplg.jpg'),
  filename: 'marion2_dpnplg.jpg',
  content_type: 'image/jpg'
)

carole = User.create!(email: 'carole@mail.com', password: 'carole', username: 'carole')
carole.photo.attach(
  io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1645623392/Users/carole_s23qgu.jpg'),
  filename: 'carole_s23qgu.jpg',
  content_type: 'image/jpg'
)

charles = User.create!(email: 'charles@mail.com', password: 'charles', username: 'charles')
charles.photo.attach(
  io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1645623392/Users/charles_spxno4.jpg'),
  filename: 'charles_spxno4.jpg',
  content_type: 'image/jpg'
)
julia = User.create!(email: 'julia@mail.com', password: 'julia', username: 'julia')
julia.photo.attach(
  io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1645623392/Users/julia_cw99zc.jpg'),
  filename: 'julia_cw99zc.jpg',
  content_type: 'image/jpg'
)

puts "The 4 best users on earth have been created out of nowhere"

puts "Creating 4 Walks"

walk_one = Walk.create!(

  user: carole,
  name: "Around the Chartrons",
  description: "A nice stroll around cute alleys to discover this atypical neighborhood",
  date: "20220302",
  duration: "1200",
  length: "2.2",
  published: true
)
walk_one.photos.attach(
  [
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk_two_1_dififz.jpg'),
      filename: 'wwalk_two_1_dififz.jpg',
      content_type: 'image/jpg'
    },
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk_two_2_bk4o4i.jpg'),
      filename: 'walk_two_2_bk4o4i.jpg',
      content_type: 'image/jpg'
    }
  ]
)

walk_two = Walk.create!(
  user: charles,
  original_walk: nil,
  name: "Jardin Public and Quinconces",
  description: "Bordeaux's golden triangle, for chic doggies and their owners",
  date: "20220301",
  duration: "660",
  length: "1.5",
  published: true
)
walk_two.photos.attach(
  [
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk2_2_vpfgf7.jpg'),
      filename: 'walk2_2_vpfgf7.jpg',
      content_type: 'image/jpg'
    },
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk2_1_ceoxvr.jpg'),
      filename: 'walk2_1_ceoxvr.jpg',
      content_type: 'image/jpg'
    },
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk2_3_we0jje.jpg'),
      filename: 'walk2_3_we0jje.jpg',
      content_type: 'image/jpg'
    }
  ]
)

walk_three = Walk.create!(
  user: marion,
  original_walk: nil,
  name: "Circle around the two bridges",
  description: "Beautiful hausmanian style buildings and a sweet walk along the riverside",
  date: "20220402",
  duration: "4000",
  length: "7",
  published: true
)
walk_three.photos.attach(
  [
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646406052/Walks/Walk3/tourdesponts_mo2pil.jpg'),
      filename: 'walk_three_1_cacmpw.jpg',
      content_type: 'image/jpg'
    },
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646406185/Walks/Walk3/200923-CITY-PARK-OPEN-CLOSED-STREETS-KEVINJBEATY-01-1200x630_yq9lzo.jpg'),
      filename: 'walk_three_2_nd2rty.jpg',
      content_type: 'image/jpg'
    }
  ]
)

walk_four = Walk.create!(
  user: cedric,
  original_walk: nil,
  name: "Long walk around Mérignac",
  description: "Discover this cute residential area with nice parks",
  date: "20220523",
  duration: "2700",
  length: "4.8",
  published: true
)
walk_four.photos.attach(
  [
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646406052/Walks/Walk4/walk_four_1_o4whxf.jpg'),
      filename: 'walk_four_1_o4whxf.jpg',
      content_type: 'image/jpg'
    },
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646406185/Walks/Walk4/walk_four_2_o7yhvm.jpg'),
      filename: 'walk_four_2_o7yhvm.jpg',
      content_type: 'image/jpg'
    }
  ]
)

puts "Fake walks created... You walked a lot, take a break :)"

puts "Creating many Waypoints"

# Walks created with https://geojson.io/ and https://replit.com/@CdricL/Generate-Waypoints-from-geoJson
# Walk one
Waypoint.create!(walk: walk_one, longitude: '-0.5539512634277344', latitude: '44.86027982426265')
Waypoint.create!(walk: walk_one, longitude: '-0.5553674697875977', latitude: '44.85950411819097')
Waypoint.create!(walk: walk_one, longitude: '-0.5608177185058593', latitude: '44.85700961998633')
Waypoint.create!(walk: walk_one, longitude: '-0.5628776550292969', latitude: '44.858986975003894')
Waypoint.create!(walk: walk_one, longitude: '-0.5603671073913574', latitude: '44.860295034081176')
Waypoint.create!(walk: walk_one, longitude: '-0.5611181259155273', latitude: '44.86084258487141')
Waypoint.create!(walk: walk_one, longitude: '-0.5593585968017577', latitude: '44.86178557680361')
Waypoint.create!(walk: walk_one, longitude: '-0.5604314804077148', latitude: '44.86286543569054')
Waypoint.create!(walk: walk_one, longitude: '-0.5586075782775879', latitude: '44.864234241789056')
Waypoint.create!(walk: walk_one, longitude: '-0.5544877052307129', latitude: '44.860751326768')

# Walk two
Waypoint.create!(walk: walk_two, longitude: '-0.5753874778747559', latitude: '44.849289680236346')
Waypoint.create!(walk: walk_two, longitude: '-0.5739927291870117', latitude: '44.85154872537361')
Waypoint.create!(walk: walk_two, longitude: '-0.5718684196472168', latitude: '44.85091741865007')
Waypoint.create!(walk: walk_two, longitude: '-0.5710101127624512', latitude: '44.850537110055')
Waypoint.create!(walk: walk_two, longitude: '-0.5697441101074219', latitude: '44.85021764889445')
Waypoint.create!(walk: walk_two, longitude: '-0.5702698230743408', latitude: '44.84917558469707')
Waypoint.create!(walk: walk_two, longitude: '-0.5707097053527832', latitude: '44.847905305761344')
Waypoint.create!(walk: walk_two, longitude: '-0.5708813667297363', latitude: '44.84656653835979')
Waypoint.create!(walk: walk_two, longitude: '-0.5750441551208496', latitude: '44.846201414577415')
Waypoint.create!(walk: walk_two, longitude: '-0.5753982067108154', latitude: '44.84782924026543')
Waypoint.create!(walk: walk_two, longitude: '-0.5763423442840576', latitude: '44.84778360091967')
Waypoint.create!(walk: walk_two, longitude: '-0.5754947662353515', latitude: '44.84917558469707')

# Walk three
Waypoint.create!(walk: walk_three, longitude: '-0.5707526206970215', latitude: '44.845570049242795')
Waypoint.create!(walk: walk_three, longitude: '-0.570216178894043', latitude: '44.84316623355929')
Waypoint.create!(walk: walk_three, longitude: '-0.5689072608947754', latitude: '44.8403667268484')
Waypoint.create!(walk: walk_three, longitude: '-0.5672550201416016', latitude: '44.838480026033636')
Waypoint.create!(walk: walk_three, longitude: '-0.5653882026672362', latitude: '44.83682150413406')
Waypoint.create!(walk: walk_three, longitude: '-0.5606245994567871', latitude: '44.83981898136341')
Waypoint.create!(walk: walk_three, longitude: '-0.5621910095214844', latitude: '44.840944896988866')
Waypoint.create!(walk: walk_three, longitude: '-0.5619120597839354', latitude: '44.84121876503036')
Waypoint.create!(walk: walk_three, longitude: '-0.5635643005371094', latitude: '44.842648943651994')
Waypoint.create!(walk: walk_three, longitude: '-0.5641007423400879', latitude: '44.84331837676571')
Waypoint.create!(walk: walk_three, longitude: '-0.5647444725036621', latitude: '44.84614816716577')
Waypoint.create!(walk: walk_three, longitude: '-0.5646371841430664', latitude: '44.84683277299209')
Waypoint.create!(walk: walk_three, longitude: '-0.5642509460449219', latitude: '44.84765428924366')
Waypoint.create!(walk: walk_three, longitude: '-0.5631780624389648', latitude: '44.848475793778825')
Waypoint.create!(walk: walk_three, longitude: '-0.5622124671936035', latitude: '44.84923643567947')
Waypoint.create!(walk: walk_three, longitude: '-0.559852123260498', latitude: '44.85065120289719')
Waypoint.create!(walk: walk_three, longitude: '-0.549488067626953', latitude: '44.85603612795718')
Waypoint.create!(walk: walk_three, longitude: '-0.5537581443786621', latitude: '44.86031024389566')
Waypoint.create!(walk: walk_three, longitude: '-0.5581569671630859', latitude: '44.858196041145334')
Waypoint.create!(walk: walk_three, longitude: '-0.5623197555541992', latitude: '44.856385978549646')
Waypoint.create!(walk: walk_three, longitude: '-0.564572811126709', latitude: '44.85504740826973')
Waypoint.create!(walk: walk_three, longitude: '-0.5669331550598145', latitude: '44.8532980933905')
Waypoint.create!(walk: walk_three, longitude: '-0.5690574645996094', latitude: '44.85130533082998')
Waypoint.create!(walk: walk_three, longitude: '-0.5698513984680176', latitude: '44.85027089254426')
Waypoint.create!(walk: walk_three, longitude: '-0.5704092979431152', latitude: '44.848871328820756')
Waypoint.create!(walk: walk_three, longitude: '-0.5710530281066893', latitude: '44.84631551600802')
Waypoint.create!(walk: walk_three, longitude: '-0.570838451385498', latitude: '44.845767827079875')

# Walk four
Waypoint.create!(walk: walk_four, longitude: '-0.6233936548233032', latitude: '44.827818625353416')
Waypoint.create!(walk: walk_four, longitude: '-0.6233185529708862', latitude: '44.828693676328626')
Waypoint.create!(walk: walk_four, longitude: '-0.6232488155364989', latitude: '44.828701285409274')
Waypoint.create!(walk: walk_four, longitude: '-0.6227767467498779', latitude: '44.82868036043507')
Waypoint.create!(walk: walk_four, longitude: '-0.6216824054718018', latitude: '44.828634705919484')
Waypoint.create!(walk: walk_four, longitude: '-0.6210708618164062', latitude: '44.82859666046224')
Waypoint.create!(walk: walk_four, longitude: '-0.6210494041442871', latitude: '44.82816294047449')
Waypoint.create!(walk: walk_four, longitude: '-0.6211674213409424', latitude: '44.827668343523214')
Waypoint.create!(walk: walk_four, longitude: '-0.6213927268981934', latitude: '44.827333537024366')
Waypoint.create!(walk: walk_four, longitude: '-0.621575117111206', latitude: '44.82702916579244')
Waypoint.create!(walk: walk_four, longitude: '-0.6215643882751465', latitude: '44.82666391819262')
Waypoint.create!(walk: walk_four, longitude: '-0.6226909160614014', latitude: '44.82660304336764')
Waypoint.create!(walk: walk_four, longitude: '-0.6225621700286865', latitude: '44.82629866827846')
Waypoint.create!(walk: walk_four, longitude: '-0.6224441528320312', latitude: '44.82600951045509')
Waypoint.create!(walk: walk_four, longitude: '-0.6224441528320312', latitude: '44.82575078906783')
Waypoint.create!(walk: walk_four, longitude: '-0.6226158142089844', latitude: '44.8256518658776')
Waypoint.create!(walk: walk_four, longitude: '-0.622551441192627', latitude: '44.82538553336783')
Waypoint.create!(walk: walk_four, longitude: '-0.6227231025695801', latitude: '44.82514963783161')
Waypoint.create!(walk: walk_four, longitude: '-0.6228840351104735', latitude: '44.82498983708117')
Waypoint.create!(walk: walk_four, longitude: '-0.6239354610443115', latitude: '44.824784378322576')
Waypoint.create!(walk: walk_four, longitude: '-0.6246006488800049', latitude: '44.824639795794226')
Waypoint.create!(walk: walk_four, longitude: '-0.62522292137146', latitude: '44.82465501502481')
Waypoint.create!(walk: walk_four, longitude: '-0.6254053115844727', latitude: '44.82474633032396')
Waypoint.create!(walk: walk_four, longitude: '-0.6252443790435791', latitude: '44.82539314288521')
Waypoint.create!(walk: walk_four, longitude: '-0.6250190734863281', latitude: '44.825994291582106')
Waypoint.create!(walk: walk_four, longitude: '-0.6251585483551025', latitude: '44.8263214964659')
Waypoint.create!(walk: walk_four, longitude: '-0.6252551078796387', latitude: '44.826610652724284')
Waypoint.create!(walk: walk_four, longitude: '-0.6252765655517578', latitude: '44.82674001163342')
Waypoint.create!(walk: walk_four, longitude: '-0.6250083446502686', latitude: '44.82669435558099')
Waypoint.create!(walk: walk_four, longitude: '-0.6247293949127197', latitude: '44.82667913688882')
Waypoint.create!(walk: walk_four, longitude: '-0.6244826316833496', latitude: '44.82696068204374')
Waypoint.create!(walk: walk_four, longitude: '-0.6241822242736816', latitude: '44.82715852376239')
Waypoint.create!(walk: walk_four, longitude: '-0.6240105628967285', latitude: '44.827333537024366')
Waypoint.create!(walk: walk_four, longitude: '-0.6236672401428223', latitude: '44.82740202033007')
Waypoint.create!(walk: walk_four, longitude: '-0.6236172839999199', latitude: '44.827425561447626')
Waypoint.create!(walk: walk_four, longitude: '-0.6235482171177864', latitude: '44.827494282432724')
Waypoint.create!(walk: walk_four, longitude: '-0.623517706990242', latitude: '44.827538511120274')
Waypoint.create!(walk: walk_four, longitude: '-0.6234221532940865', latitude: '44.82773920430843')
Waypoint.create!(walk: walk_four, longitude: '-0.6233970075845718', latitude: '44.827814345180144')

puts "Waypoints created... Did you take your swimming suit for waypoint 3 ?"

puts "Creating 4 Hotspots"

hotspot_park1 = Hotspot.create!(
  category: "dog park",
  name: "My favorite park",
  longitude: "0.5642509460449219",
  latitude: "44.84765428924366"
)

hotspot_park2 = Hotspot.create!(
  category: "dog park",
  name: "A lovely park",
  longitude: "-0.5646800994873047",
  latitude: "44.846984906515225"
)

hotspot_park3 = Hotspot.create!(
  category: "dog park",
  name: "very big dog park",
  longitude: "-0.622551441192627",
  latitude: "44.82538553336783"
)

hotspot_dispenser1 = Hotspot.create!(
  category: "dispenser",
  name: "My favorite dispenser",
  longitude: "-0.5695724487304688",
  latitude: "44.8500274926005"
)

hotspot_dispenser2 = Hotspot.create!(
  category: "dispenser",
  name: "My daughters' dispenser",
  longitude: "-0.6233105063438414",
  latitude: "44.82851200922972"
)

hotspot_fountain1 = Hotspot.create!(
  category: "fountain",
  name: "My favorite fountain",
  longitude: "-0.5603671073913574",
  latitude: "44.860295034081176"
)

hotspot_fountain2 = Hotspot.create!(
  category: "fountain",
  name: "beautiful fountain",
  longitude: "-0.6232917308807373",
  latitude: "44.82781672305423"
)


puts "Hotspots created... Feeling hot yet ?"

puts "Creating 7 Reviews"

# -----reviews for walk_one (chartrons)-----

review1 = Review.create!(walk: walk_one, user: charles, comment: "I liked it, but i couldn't find any poop-bags dispenser", rating: 5)
review1.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk_two_1_dififz.jpg'), filename: 'wwalk_two_1_dififz.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/walk_two_2_bk4o4i.jpg'), filename: 'walk_two_2_bk4o4i.jpg', content_type: 'image/jpg' }])

review2 = Review.create!(walk: walk_one, user: gala, comment: "Not enough grass, my dog refused to pee", rating: 5)
review2.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/chartrons_gala_1_ok7egu.jpg'), filename: 'chartrons_gala_1_ok7egu.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/chartrons_gala_2_ezwqvh.jpg'), filename: 'chartrons_gala_2_ezwqvh.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/chartrons_gala_3_fvzttx.jpg'), filename: 'chartrons_gala_3_fvzttx.jpg', content_type: 'image/jpg' }])

review3 = Review.create!(walk: walk_one, user: cedric, comment: "I loved the fountain in this hot summer weather", rating: 5)
review3.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/chartrons_cedric_1_d3nvfv.jpg'), filename: 'chartrons_cedric_1_d3nvfv.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/chartrons_cedric_2_lqjhpm.jpg'), filename: 'chartrons_cedric_2_lqjhpm.jpg', content_type: 'image/jpg' }])

# -----reviews for walk_two (jardin public)-----

review4 = Review.create!(walk: walk_two, user: carole, comment: "Since i hate nature, i stayed around Quinquonces and i loved it", rating: 5)
review4.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_carole_1_atmcrq.jpg'), filename: 'jardin_carole_1_atmcrq.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_carole_2_mx8lra.jpg'), filename: 'jardin_carole_2_mx8lra.jpg', content_type: 'image/jpg' }])

review5 = Review.create!(walk: walk_two, user: marion, comment: "Beautiful park, my dogs met so many friends", rating: 5)
review5.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_marion_2_fvmj7f.jpg'), filename: 'jardin_marion_2_fvmj7f.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_marion_1_qjjuhx.jpg'), filename: 'jardin_marion_1_qjjuhx.jpg', content_type: 'image/jpg' }])

review6 = Review.create!(walk: walk_two, user: julia, comment: "The Jardin Public is so huge i lost my dog for a while", rating: 4)
review6.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_julia_1_q6ovtg.jpg'), filename: 'jardin_julia_1_q6ovtg.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_julia_2_jpguuf.jpg'), filename: 'jardin_julia_2_jpguuf.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk2/jardin_julia_3_klv8oa.jpg'), filename: 'jardin_julia_3_klv8oa.jpg', content_type: 'image/jpg' }])

# -----reviews for walk_three (the two bridges)-----

review5 = Review.create!(walk: walk_three, user: julia, comment: "Great walk, I've spent a nice moment with my dog", rating: 5)
review5.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646405675/Walks/Walk3/Bordeaux_La_Garonne_OK_fnpho7.jpg'), filename: 'wwalk_three_1_dififz.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646404712/Walks/Walk3/french-bulldog-walking-on-leash-in-park_pmtqxa.jpg'), filename: 'walk_three_2_bk4o4i.jpg', content_type: 'image/jpg' }])

review6 = Review.create!(walk: walk_three, user: cedric, comment: "It was raining...", rating: 3)
review6.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646404654/Walks/Walk3/IMG_1162_scgapg.jpg'), filename: 'wwalk_two_1_dififz.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646404658/Walks/Walk3/IMG_3597_oz46wj.jpg'), filename: 'walk_two_2_bk4o4i.jpg', content_type: 'image/jpg' }])

review7 = Review.create!(walk: walk_three, user: carole, comment: "Awesome tour by night, the lights reflecting in the water are beautiful", rating: 5)
review7.photos.attach([{ io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646404654/Walks/Walk3/bridges_carole_1_hwmxe6.jpg'), filename: 'bridges_carole_1_hwmxe6.jpg', content_type: 'image/jpg' },
                       { io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646404658/Walks/Walk3/bridges_carole_2_x7mw37.jpg'), filename: 'bridges_carole_2_x7mw37.jpg', content_type: 'image/jpg' }])

puts "Reviews created... Disclaimer : Woolks takes no responsability for fake reviews !"

puts "Creating 8 hotspot_walks"

# -----Walk_one hotspots-----
HotspotWalk.create!(hotspot: hotspot_fountain1, walk: walk_one)

# -----Walk_two hotspots-----
HotspotWalk.create!(hotspot: hotspot_park2, walk: walk_two)
HotspotWalk.create!(hotspot: hotspot_dispenser1, walk: walk_two)

# -----Walk_three hotspots-----
HotspotWalk.create!(hotspot: hotspot_dispenser1, walk: walk_three)
HotspotWalk.create!(hotspot: hotspot_park1, walk: walk_three)

# -----Walk_four hotspots-----
HotspotWalk.create!(hotspot: hotspot_dispenser2, walk: walk_four)
HotspotWalk.create!(hotspot: hotspot_park3, walk: walk_four)
HotspotWalk.create!(hotspot: hotspot_fountain2, walk: walk_four)

puts "hotspots_walks created... Toss a coin ! Are you gonna get lucky this time ?"

puts "Creating 1 favorite_walk"

FavoriteWalk.create!(user: marion, walk: walk_two)

puts "1 favorite_walk created... Marion's ready to do it everyday !"

puts "DB seeded EVERYWHEEEEERE !"
