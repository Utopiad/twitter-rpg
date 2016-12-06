require 'test_helper'

class WorldTest < ActiveSupport::TestCase

  test "world can be created" do
    assert World.new
  end

  test "world can be named" do
    name = "name"
    world = World.new(name: name)
    assert_equal(world.name, name)
  end

  test "world can be saved" do
    name = "name"
    u = User.new(email: "martin@gmail.com", password: "aaaaaa")
    u.save
    world = World.new(user: u, name: name)
    assert world.save
  end

  test "world can be fetched" do
    name = "name"
    u = User.new(email: "martin@gmail.com", password: "aaaaaa")
    u.save
    world = World.new(user: u, name: name)
    world.save
    fetched_world = World.where(id: world.id).first
    assert_equal(fetched_world.name, world.name)
  end

  test "world shouldn't be saved without a user" do
    world = World.new(name: name)
    assert_not world.save
  end

  test "world shouldn't be saved without a name" do
    u = User.new(email: "martin@gmail.com", password: "aaaaaa")
    u.save
    world = World.new(user: u)
    assert_not world.save
  end
end
