json.(gift, :tag_list, :text, :image, :created_at, :updated_at, :gift_id, :expire_at)
json.provider gift.provider, partial: 'profiles/profile', as: :user
json.receiver gift.receiver, partial: 'profiles/profile', as: :user
