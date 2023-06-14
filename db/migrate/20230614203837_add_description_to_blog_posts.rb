class AddDescriptionToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :description, :text
  end
end
