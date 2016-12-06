require 'rails_helper'

RSpec.describe "worlds/new", type: :view do
  before(:each) do
    assign(:world, World.new(
      :user => nil
    ))
  end

  it "renders new world form" do
    render

    assert_select "form[action=?][method=?]", worlds_path, "post" do

      assert_select "input#world_user_id[name=?]", "world[user_id]"
    end
  end
end
