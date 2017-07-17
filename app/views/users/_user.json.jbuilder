json.(user, :username, :email, :bio, :mobileNum)
json.proPic user.proPic || 'https://res.cloudinary.com/unimemo-dfd94/image/upload/v1500289994/c6zgp0zjykx6t4uxva19.jpg'
json.mem user.mem || 0
json.greyStars user.greyStars || 0
json.yellowStars user.yellowStars || 0
json.token user.generate_jwt
