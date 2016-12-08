require 'rails_helper'

RSpec.describe WorldController, type: :controller do

  render_views


  describe "HOME world" do

    it "no world appears for new users" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      sign_in freddy

      get :root
      expect(response).to have_http_status(:success)

      expect(response.body).to include("Vous n'avez pas encore rejoint de mondes")
      expect(response.body).to_not include(world.name)
      expect(response.body).to_not include("Player")
      expect(response.body).to_not include("Game Master")
    end

    it "display world where being GM" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.create(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      sign_in bob

      get :root
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include("Game Master")
      expect(response.body).to_not include("Player")
    end

    it "display world where having character" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :user_id => freddy.id)

      sign_in freddy

      get :root
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include(charac.name)
      expect(response.body).to include("Player")
      expect(response.body).to_not include("Game Master")
    end

  end


  describe "LIST worlds" do

    it "display sentance when no public world" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      sign_in bob

      get :join
      expect(response).to have_http_status(:success)

      expect(response.body).to include("Sorry no world need characters right now, come later.")
      expect(response.body).to_not include(world.name)
    end

    it "have worlds informations" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      sign_in bob

      get :join
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include(bob.name)
    end

    it "list just public worlds" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world1 = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      world2 = World.new(
          :name => 'theWorldOfDevianArt',
          :public => 0,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      world3 = World.new(
          :name => 'westWorld',
          :public => 1,
          :user_id => freddy.id)

      sign_in freddy

      get :join
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world1.name)
      expect(response.body).to include(world3.name)
      expect(response.body).to_not include(world2.name)
    end

  end


  describe "JOIN a world" do

    it "can join public worlds" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      sign_in freddy

      get :newcharacter, params: { id: world.id }
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include("Specify your character")
    end

    it "can't join private worlds" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 0,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      sign_in freddy

      get :newcharacter, params: { id: world.id }
      expect(response).to have_http_status(403)

      expect(response.body).to include ("Sorry you don't have access to this world.")
    end

    it "can join private worlds with url" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 0,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      sign_in freddy

      post :join, params: {
          world: { url: url }
      }
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include("Specify your character")
    end

    it "can't join world where being GM" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 0,
          :user_id => bob.id)

      sign_in bob

      get :newcharacter, params: { id: world.id }
      expect(response).to have_http_status(403)

      expect(response.body).to include ("You can't join a world where you already in.")
    end


    it "can't join two time a world" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 0,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :user_id => freddy.id)

      sign_in freddy

      get :newcharacter, params: { id: world.id }
      expect(response).to have_http_status(403)

      expect(response.body).to include ("You can't join a world where you already in.")
    end

    it "can't join a full world" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 0,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :user_id => freddy.id)

      kurt = User.new(
          :pseudo => 'kurt',
          :email => 'kurt.cobain@gmail.com',
          :encrypted_password => 'password'
      )

      sign_in kurt

      get :newcharacter, params: { id: world.id }
      expect(response).to have_http_status(403)

      expect(response.body).to include("Sorry this world is full.")
    end

  end


  ####################################################################################################


  describe "participe on the world" do

    it "Join world where he is GM" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.create(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      sign_in bob

      get :world, params: { id: world.id }
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include(bob.name)

    end

    it "Join world where he is player" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      freddy = User.new(
          :email => 'freddy.mercury@gmail.com',
          :password => 'password',
          :encrypted_password => 'password')

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :user_id => freddy.id)

      sign_in freddy

      get :world, params: { id: world.id }
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include(bob.name)
      expect(response.body).to include(charac.name)

    end

    it "can't join world where he is not" do
      bob = User.new(
          :email => 'bob.marley@gmail.com',
          :password => 'password',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      sign_in freddy

      get :world, params: { id: world.id }
      expect(response).to have_http_status(403)

      expect(response.body).to include("You not belong to this world")
      expect(response.body).to_not include(world.name)
    end

  end

end