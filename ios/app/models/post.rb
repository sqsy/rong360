class Post
  extend CommonModel

  attrs_with %w{ id user_id title content post_at }
end
