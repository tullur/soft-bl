json.extract! comment, :id, :body, :commentable_type, :commentable_id, :created_at, :update_at, :user_id
json.url article_url(comment, format: :json)
