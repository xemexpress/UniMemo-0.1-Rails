json.(user, :username, :bio)
json.proPic user.proPic || 'https://res.cloudinary.com/unimemo-dfd94/image/upload/v1500289994/c6zgp0zjykx6t4uxva19.jpg'
json.yellowStars user.yellowStars || 0
json.favoring signed_in? ? current_user.following?(user) : false
