require "test_helper"

class BlogPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog_post = blog_posts(:one)
  end

  class BlogPostsControllerUserTest < BlogPostsControllerTest
    setup do
      @user = users(:one)
      sign_in @user
      @blog_post = blog_posts(:one)
    end

    test "should get index" do
      get blog_posts_url
      assert_response :success
    end

    test "should get new" do
      get new_blog_post_url
      assert_response :success
    end

    test "should create blog_post" do
      assert_difference("BlogPost.count") do
        post blog_posts_url, params: {
          blog_post: {
            title: @blog_post.title,
            body: 'Some text',
            slug: @blog_post.slug
          }
        }
      end

      assert_redirected_to blog_post_url(BlogPost.last)
    end

    test "should show blog_post" do
      get blog_post_url(@blog_post)
      assert_response :success
    end

    test "should get edit" do
      get edit_blog_post_url(@blog_post)
      assert_response :success
    end

    test "should update blog_post" do
      patch blog_post_url(@blog_post), params: {
        blog_post: {
          title: @blog_post.title,
          body: 'Some other text',
          slug: @blog_post.slug
        }
      }
      assert_redirected_to blog_post_url(@blog_post)
    end

    test "should destroy blog_post" do
      assert_difference("BlogPost.count", -1) do
        delete blog_post_url(@blog_post)
      end

      assert_redirected_to root_url
    end
  end

  class BlogPostsControllerGuestTest < BlogPostsControllerTest
    setup do
      @blog_post = blog_posts(:one)
    end

    test "should get index" do
      get blog_posts_url
      assert_response :success
    end

    test "should not get new" do
      get new_blog_post_url
      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should not create blog_post" do
      assert_no_difference("BlogPost.count") do
        post blog_posts_url, params: {
          blog_post: {
            title: @blog_post.title,
            body: 'Some text',
            slug: @blog_post.slug
          }
        }
      end

      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should show blog_post" do
      get blog_post_url(@blog_post)
      assert_response :success
    end

    test "should not get edit" do
      get edit_blog_post_url(@blog_post)
      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should not update blog_post" do
      patch blog_post_url(@blog_post), params: {
        blog_post: {
          title: @blog_post.title,
          body: 'Some other text',
          slug: @blog_post.slug
        }
      }

      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should not destroy blog_post" do
      assert_no_difference("BlogPost.count") do
        delete blog_post_url(@blog_post)
      end

      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end
  end
end

