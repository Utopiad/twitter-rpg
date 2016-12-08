require 'rails_helper'

RSpec.describe WorldController, type: :controller do

  render_views


  describe "HOME world" do

    it "New users can't see any world" do
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

      expect(response.body).to include("You have not join a world yet!")
      expect(response.body).to_not include(world.name)
      expect(response.body).to_not include("Player")
      expect(response.body).to_not include("Game Master")
    end

    it "User can see the world he just created (GM)" do
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

    it "User can see the world he just joined (character)" do
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

    it "Display a message when none public world exists" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      sign_in bob

      get :join
      expect(response).to have_http_status(:success)

      expect(response.body).to include("Sorry, no worlds available right now.")
      expect(response.body).to_not include(world.name)
    end

    it "Have worlds informations" do
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

    it "Only list public worlds" do
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


  describe "Joining world" do

    it "User can join public worlds" do
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
      expect(response.body).to include("Create your character")
    end

    it "User can't join private worlds" do
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

    # @need_review todo: recheck ce test après mise en place du système
    it "User can join private worlds with a code" do
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
          world: { code: url }
      }

      expect(response).to redirect_to(:world/new_character_path)
    end

    it "User can't join a world as a character if he is a GM" do
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

      expect(response.body).to include ("You can't join a world where you are already god.")
    end


    it "User can't create a second character in the same world" do
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

      type = CharacterType.new

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      sign_in freddy

      get :newcharacter, params: { id: world.id }
      expect(response).to have_http_status(403)

      expect(response.body).to include ("You can't join a world where you are already in.")
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

      type = CharacterType.new

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :character_type_id => type.id,
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


  describe "Can play in the world" do

    it "User can join a world as a GM" do
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

    it "User can join a world as character" do
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

      type = CharacterType.new

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      sign_in freddy

      get :world, params: { id: world.id }
      expect(response).to have_http_status(:success)

      expect(response.body).to include(world.name)
      expect(response.body).to include(bob.name)
      expect(response.body).to include(charac.name)

    end

    it "User can't join a world where he is not registered" do
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

      expect(response.body).to include("You don't belong to this world.")
      expect(response.body).to_not include(world.name)
    end

  end

end