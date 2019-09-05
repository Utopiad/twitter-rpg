# frozen_string_literal: true

require 'test_helper'

class ClasseTest < ActiveSupport::TestCase
  test 'classe can be created' do
    assert Classe.new
  end

  test 'classe can be named' do
    name = 'name'
    classe = Classe.new(name: name)
    assert_equal(classe.name, name)
  end

  test 'classe can be saved' do
    name = 'name'
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, name: name, attack_min: 1,
                        attack_max: 1, armor: 1, life: 1)
    assert classe.save
  end

  test 'classe can be fetched' do
    name = 'name'
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, name: name, attack_min: 1,
                        attack_max: 1, armor: 1, life: 1)
    classe.save
    fetched_classe = Classe.where(id: classe.id).first
    assert_equal(fetched_classe.name, classe.name)
  end

  test "classe shouldn't be saved without a user" do
    classe = Classe.new(name: name)
    assert_not classe.save
  end

  test "classe shouldn't be saved without a name" do
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, attack_min: 1, attack_max: 1, armor: 1, life: 1)
    assert_not classe.save
  end

  test "classe shouldn't be saved without attack min" do
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, attack_max: 1, armor: 1, life: 1)
    assert_not classe.save
  end

  test "classe shouldn't be saved without attack max" do
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, attack_min: 1, armor: 1, life: 1)
    assert_not classe.save
  end

  test "classe shouldn't be saved without armor" do
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, attack_min: 1, attack_max: 1, life: 1)
    assert_not classe.save
  end

  test "classe shouldn't be saved without life" do
    u = User.new(email: 'martin@gmail.com', password: 'aaaaaa')
    u.save
    w = World.new(user: u, name: name)
    w.save
    classe = Classe.new(world: w, attack_min: 1, attack_max: 1, armor: 1)
    assert_not classe.save
  end
end
