json.extract! rating, :id, :rating, :comment, :user_id, :product_id, :created_at, :updated_at
json.url rating_url(rating, format: :json)
