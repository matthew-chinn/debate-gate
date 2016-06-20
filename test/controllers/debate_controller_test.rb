require 'test_helper'

class DebateControllerTest < ActionController::TestCase
  def setup
    @controller = DebatesController.new
  end

  test "should fail create" do
    post :create, debate: { title: "hi" }
    assert_template :new
  end

  test "should pass create" do
    assert_difference('Debate.count') do
      post :create, debate: { title: "hi", description: "desc" }
    end
  end
end
