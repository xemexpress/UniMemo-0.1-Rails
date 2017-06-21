json.(request, :tag_list, :start_time, :start_place, :end_time, :end_place, :text, :image, :created_at, :updated_at, :request_id)
json.wished signed_in? ? current_user.wished?(request) : false
json.wishes_count request.wishes_count || 0
json.poster request.poster, partial: 'profiles/profile', as: :user
json.taking signed_in? ? current_user.following?(request) : false
json.helper request.helper, partial: 'profiles/profile', as: :user
