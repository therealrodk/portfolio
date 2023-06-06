module BlogPostHelper
  def select_justification(blog_post)
    blog_post.persisted? ? 'between' : 'end'
  end
end