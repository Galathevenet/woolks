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

puts "Creating 4 Users"
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

puts "The 4 best users on earth have been created out of nowhere"

puts "Creating 2 Walks"

walk_one = Walk.create!(
  user: cedric,
  name: "Dans les chartrons",
  description: "Jolies petites ruelles",
  date: "20220302",
  duration: "1200",
  length: "2200",
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
  user: gala,
  original_walk: walk_one,
  name: "Jardin Public et Quinconces",
  description: "Le triangle d'or, pour les toutous chics",
  date: "20220301",
  duration: "660",
  length: "1500",
  published: false
)
walk_two.photos.attach(
  [
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/walk_one_1_cacmpw.jpg'),
      filename: 'walk_one_1_cacmpw.jpg',
      content_type: 'image/jpg'
    },
    {
      io: URI.open('https://res.cloudinary.com/djcv5afgd/image/upload/v1646228557/Walks/Walk1/walk_one_2_nd2rty.jpg'),
      filename: 'walk_one_2_nd2rty.jpg',
      content_type: 'image/jpg'
    }
  ]
)

walk_three = Walk.create!(
  user: marion,
  original_walk: nil,
  name: "Tours des 2 ponts",
  description: "Un super tour plein d'immeubles",
  date: "20220402",
  duration: "4000",
  length: "7000",
  published: true
)

puts "Fake walks created... You walked a lot, take a break :)"

puts "Creating Waypoints"

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

puts "Waypoints created... Did you take your swimming suit for waypoint 3 ?"

puts "Creating 2 Hotspots"

hotspot_park1 = Hotspot.create!(
  category: "park",
  name: "My favorite park",
  longitude: "-0.5762243270874023",
  latitude: "44.848293238227974"
)

hotspot_dispenser1 = Hotspot.create!(
  category: "dispenser",
  name: "My favorite dispenser",
  longitude: "-0.5695724487304688",
  latitude: "44.8500274926005"
)

hotspot_fountain1 = Hotspot.create!(
  category: "fountain",
  name: "My favorite fountain",
  longitude: "-0.556408166885376",
  latitude: "44.84931249931707"
)

puts "Hotspots created... Feeling hot yet ?"

puts "Creating 2 Reviews"

Review.create!(
  walk: walk_one,
  user: marion,
  comment: "J'ai bien aimé mais ça manque de sacs à crottes",
  rating: 4
)

Review.create!(
  walk: walk_two,
  user: carole,
  comment: "J'ai adoré comme je n'aime pas la nature, meilleure expérience sur du bitume !",
  rating: 5
)

puts "Reviews created... Disclaimer : Woolks takes no responsability for fake reviews !"

puts "Creating 2 hotspot_walks"

HotspotWalk.create!(hotspot: hotspot_park1, walk: walk_two)
HotspotWalk.create!(hotspot: hotspot_dispenser1, walk: walk_two)
HotspotWalk.create!(hotspot: hotspot_dispenser1, walk: walk_three)

puts "hotspots_walks created... Toss a coin ! Are you gonna get lucky this time ?"

puts "Creating 1 favorite_walk"

FavoriteWalk.create!(user: marion, walk: walk_two)

puts "1 favorite_walk created... Marion's ready to do it everyday !"

puts "DB seeded EVERYWHEEEEERE !"
