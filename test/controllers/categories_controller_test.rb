require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "test@example.com", password: "password")
    sign_in @user

    @category = Category.create!(name: "Test Category", user: @user)
  end

  test "should get categories index" do
    get '/categories'
    assert_response :success
  end

  test "should go to new page" do
    get '/categories/new'
    assert_response :ok
  end

  test "should create an category" do
    post categories_path, params: { category: {name: "New Category"} }
    assert_response :redirect
  end

  test "should be able to edit an category" do
    get edit_category_path(@category)
    assert_response :success
    patch category_path(@category), params: { category: { name: "Edited Name" } }
    assert_redirected_to category_path(@category)
    @category.reload
    assert_equal "Edited Name", @category.name
  end

  test "should be able to delete an category" do
    assert_difference('Category.count', -1) do
      delete category_path(@category)
    end

    assert_redirected_to root_path
  end
end
