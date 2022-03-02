puts "Destroying all the DBs...!!!"
Waypoint.destroy_all
puts "Waypoint db destroyed"
Walk.where.not(original_walk_id: nil).destroy_all
Walk.destroy_all
puts "Walk db destroyed"
User.destroy_all
puts "User db destroyed"
Hotspot.destroy_all
puts "Hotspot db destroyed"
Review.destroy_all
puts "Review db destroyed"
HotspotWalk.destroy_all
puts "Hotspot_walk db destroyed"
FavoriteWalk.destroy_all
puts "Favorite_walk db destroyed"

puts "All DBs are down ! I repeat, all DBs are down !"

puts "Creating 4 Users"
gala = User.create!(email: 'gala@mail.com', password: 'gala', username: 'gala')
cedric = User.create!(email: 'cedric@mail.com', password: 'cedric', username: 'cedric')
marion = User.create!(email: 'marion@mail.com', password: 'marion', username: 'marion')
carole = User.create!(email: 'carole@mail.com', password: 'carole', username: 'carole')

puts "The 4 best users on earth have been created out of nowhere"

puts "Creating 2 Walks"

walk_one = Walk.create!(user: gala, name: "Tour autour de Layrac", description: "Un super tour qui grimpe", date: "20220301", duration:  "3600", length: "6000", published: true)
walk_two = Walk.create!(user: cedric, name: "Tour autour de Mérignac", description: "Un super tour plein d'immeubles", date: "20220302", duration:  "3650", length: "3000", published: false)

puts "Fake walks created... You walked a lot, take a break :)"

puts "Creating 4 Waypoints"

waypoint_one = Waypoint.create!(walk: walk_one, longitude: '45.5', latitude: '32.2')
waypoint_two = Waypoint.create!(walk: walk_one, longitude: '32.5', latitude: '18.2')
waypoint_three = Waypoint.create!(walk: walk_two, longitude: '10.3', latitude: '22.2')
waypoint_four = Waypoint.create!(walk: walk_two, longitude: '48.4', latitude: '69.3')

puts "Waypoints created... Did you take your swimming suit for waypoint 3 ?"

puts "Creating 2 Hotspots"

hotspot_one = Hotspot.create!(category: "park", name: "My favorite park", longitude: "45.5", latitude: "32.2")
hotspot_two = Hotspot.create!(category: "fountain", name: "My favorite fountain", longitude: "32.5", latitude: "18.2")

puts "Hotspots created... Feeling hot yet ?"

puts "Creating 2 Reviews"

review_one = Review.create!(walk: walk_one, user: marion, comment: "J'ai bien aimé mais ça manque de sacs à crottes", rating: 4)
review_two = Review.create!(walk: walk_two, user: carole, comment: "J'ai adoré comme je n'aime pas la nature, meilleure expérience sur du bitume !", rating: 5)

puts "Reviews created... Disclaimer : Woolks takes no responsability for fake reviews !"

puts "Creating 2 hotspot_walks"

hw_one = HotspotWalk.create!(hotspot: hotspot_one, walk: walk_one)
hw_two = HotspotWalk.create!(hotspot: hotspot_two, walk: walk_two)

puts "hotspots_walks created... Toss a coin ! Are you gonna get lucky this time ?"

puts "Creating 1 favorite_walk"

fw_one = FavoriteWalk.create!(user: marion, walk: walk_one)

puts "DB seeded EVERYWHEEEEERE !"
