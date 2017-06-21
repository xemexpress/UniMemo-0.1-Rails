json.(comment, :id, :body, :created_at, :updated_at)
json.author comment.user, partial: 'profiles/profile', as: :user
