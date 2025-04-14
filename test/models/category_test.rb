require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(first_name: "Test", last_name: "Example", email: "test@example.com", password: "password")
  end

  test "should not save a category with nil title" do
    category = Category.new
    category.user = @user
    category.name = nil
    assert_not category.save
  end

  test "should save a category with a title" do
    category = Category.new
    category.user = @user
    category.name = "New Category"
    assert category.save
  end
end
