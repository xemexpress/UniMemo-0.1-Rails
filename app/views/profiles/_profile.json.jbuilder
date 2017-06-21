json.(user, :username, :bio)
json.proPic user.proPic || 'http://absfreepic.com/absolutely_free_photos/small_photos/water-on-street-2736x2386_103391.jpg'
json.yellowStars user.yellowStars || 0
json.favoring signed_in? ? current_user.following?(user) : false
