require 'rails_helper'

RSpec.describe "worlds/show", type: :view do
  before(:each) do
    @world = assign(:world, World.create!(
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
