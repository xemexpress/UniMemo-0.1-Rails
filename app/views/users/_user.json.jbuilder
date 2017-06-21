json.(user, :username, :email, :bio, :proPic, :mobileNum, :mem, :greyStars, :yellowStars)
json.mem user.mem || 0
json.greyStars user.greyStars || 0
json.yellowStars user.yellowStars || 0
json.token user.generate_jwt
