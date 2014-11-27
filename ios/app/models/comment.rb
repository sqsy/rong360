class Comment
  extend CommonModel

  attrs_with %w{ id user_id post_id message comment_at }

end
