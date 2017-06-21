class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :request, counter_cache: true
end
