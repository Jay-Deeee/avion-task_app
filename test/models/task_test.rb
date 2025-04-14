require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(first_name: "Test", last_name: "Example", email: "test@example.com", password: "password")
    @category = Category.create!(name: "Test Category", user: @user)
  end
  
  test "should not save a task without a title" do
    task = Task.new(title: nil, body: "Body of Task", date: "2025-04-15", due_date: "2025-04-16 19:00", status: "in_progress", priority: "medium", category_id: @category.id)
    assert_not task.save
  end
  
  test "should not save a task without a body" do
    task = Task.new(title: "Task", body: nil, date: "2025-04-15", due_date: "2025-04-16 19:00", status: "in_progress", priority: "medium", category_id: @category.id)
    assert_not task.save
  end

  test "should not save a task without a date" do
    task = Task.new(title: "Task", body: "Body of Task", date: nil, due_date: "2025-04-16 19:00", status: "in_progress", priority: "medium", category_id: @category.id)
    assert_not task.save
  end

  test "should not save a task without a due date" do
    task = Task.new(title: "Task", body: "Body of Task", date: "2025-04-15", due_date: nil, status: "in_progress", priority: "medium", category_id: @category.id)
    assert_not task.save
  end
end
