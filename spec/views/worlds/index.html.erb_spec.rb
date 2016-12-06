require 'rails_helper'

RSpec.describe "worlds/index", type: :view do
  before(:each) do
    assign(:worlds, [
      World.create!(
        :user => nil
      ),
      World.create!(
        :user => nil
      )
    ])
  end

  it "renders a list of worlds" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
