require 'test_helper'

class PropertyPostsControllerTest < ActionController::TestCase
  setup do
    @property_post = property_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:property_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property_post" do
    assert_difference('PropertyPost.count') do
      post :create, property_post: @property_post.attributes
    end

    assert_redirected_to property_post_path(assigns(:property_post))
  end

  test "should show property_post" do
    get :show, id: @property_post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property_post.to_param
    assert_response :success
  end

  test "should update property_post" do
    put :update, id: @property_post.to_param, property_post: @property_post.attributes
    assert_redirected_to property_post_path(assigns(:property_post))
  end

  test "should destroy property_post" do
    assert_difference('PropertyPost.count', -1) do
      delete :destroy, id: @property_post.to_param
    end

    assert_redirected_to property_posts_path
  end
end
