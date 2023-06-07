require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag = ActsAsTaggableOn::Tag.create!(name: "test_tag")
  end

  teardown do
    ActsAsTaggableOn::Tag.find_by(name: "test_tag")&.destroy
    ActsAsTaggableOn::Tag.find_by(name: "updated_test_tag")&.destroy
  end

  class TagsControllerUserTest < TagsControllerTest
    setup do
      @user = users(:one)
      sign_in @user
    end

    test "should get index" do
      get tags_url
      assert_response :success
    end

    test "should show tag" do
      get tag_url(@tag)
      assert_response :success
    end

    test "should update tag" do
      put update_tag_url(@tag), params: {
        name: 'updated_test_tag'
      }
      assert_redirected_to tag_url(@tag)
    end

    test "should destroy tag" do
      assert_difference("ActsAsTaggableOn::Tag.count", -1) do
        delete tag_url(@tag)
      end

      assert_redirected_to tags_url
    end
  end

  class TagsControllerGuestTest < TagsControllerTest
    test "should not get index" do
      get tags_url
      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should not show tag" do
      get tag_url(@tag)
      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should not update tag" do
      put update_tag_url(@tag), params: {
        name: 'updated_test_tag'
      }

      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end

    test "should not destroy tag" do
      assert_no_difference("ActsAsTaggableOn::Tag.count") do
        delete tag_url(@tag)
      end

      assert_response :redirect
      follow_redirect!
      assert_select "p", text: "You need to sign in or sign up before continuing."
    end
  end
end

