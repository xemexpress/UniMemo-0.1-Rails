json.(user, :username, :bio)
json.proPic user.proPic || 'https://res.cloudinary.com/unimemo-dfd94/image/upload/v1500267934/e68vj8e0hqhgnzgn9cnx.jpg'
json.yellowStars user.yellowStars || 0
json.favoring signed_in? ? current_user.following?(user) : false
