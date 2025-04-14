require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "test@example.com", password: "password")
    sign_in @user

    @category = Category.create!(name: "Test Category", user: @user)
    @task = Task.create!(
      title: "Test Task",
      body: "Some details",
      date: Date.today,
      due_date: Time.zone.now + 1.day,
      status: "pending",
      priority: "medium",
      category: @category
    )
  end

  test "should get index" do
    get category_tasks_url(@category)
    assert_response :success
  end

  test "should show task" do
    get category_task_url(@category, @task)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_task_url(@category, @task)
    assert_response :success
    assert_select "form"
  end

  test "should create task" do
    assert_difference("Task.count") do
      post category_tasks_url(@category), params: {
        task: {
          title: "New Task",
          body: "Body text",
          date: Date.today,
          "due_date(1i)" => "2025",
          "due_date(2i)" => "04",
          "due_date(3i)" => "12",
          due_hour: "10",
          due_minute: "30",
          due_meridian: "AM",
          status: "pending",
          priority: "medium"
        }
      }
    end

    assert_redirected_to category_url(@category)
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete category_task_url(@category, @task)
    end

    assert_redirected_to category_url(@category)
  end
end
