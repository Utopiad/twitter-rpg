require 'rails_helper'

RSpec.describe CharacterController, type: :controller do

  render_views


  describe "CONTROLLER : create works fine" do

    it "works when all arguments are corrects" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac = Character.create(
          :name => 'fred',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      last_charac_created = Character.last

      expect(Character.count).to eq(1)
      expect(last_charac_created.id).to eq(charac.id)
    end

    it "not works when there is a mistake" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac = Character.create(
          :name => '',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      expect(Character.count).to eq(0)
    end

    it "don't work when there already a character" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac1 = Character.create(
          :name => 'fred',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      charac2 = Character.create(
          :name => 'jack',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      last_charac_created = Character.last

      expect(Character.count).to eq(1)
      expect(last_charac_created.id).to eq(charac1.id)
    end
  end


  describe "VIEW : creation form view works fine" do

    it "redirect to game when the form is correct" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      post :newcharacter, params: {
          character: {
              :name => 'fredo',
              :world_id => world.id,
              :character_type_id => type.id,
              :user_id => freddy.id
          }
      }
      expext(response).to redirect_to(game_path)
    end

    it "display the error returned when a value is empty" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      post :newcharacter, params: {
          character: {
              :name => '',
              :world_id => world.id,
              :character_type_id => type.id,
              :user_id => freddy.id
          }
      }
      expext(response).to redirect_to(game_path)

      except(response.body).to include("name can't be blank")
    end

    it "display a specific error for empty tabel links" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      post :newcharacter, params: {
          character: {
              :name => 'fredo',
              :world_id => nil,
              :character_type_id => type.id,
              :user_id => freddy.id
          }
      }
      expext(response).to have_http_status(:success)

      except(response.body).to include("There is a mistake with your form. Please check and retry.")
    end

  end


  describe "VIEW : appears in GAME" do

    it "all valid characters appears in the game for players view" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      fredo = Character.create(
          :name => "fredo",
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      kurt = User.new(
          :pseudo => 'kurt',
          :email => 'kurt.cobain@gmail.com',
          :encrypted_password => 'password')

      kurty = Character.create(
          :name => "kurty",
          :world_id => world.id,
          :character_type_id => 450,
          :user_id => kurt.id)

      jimi = User.new(
          :pseudo => 'jimi',
          :email => 'jimi.hendrix@gmail.com',
          :encrypted_password => 'password')

      jim = Character.create(
          :name => "jim",
          :world_id => world.id,
          :character_type_id => 450,
          :user_id => jimi.id)

      sign_in freddy

      get :game, params: { id: world.id }
      except(response).to have_http_status(:success)

      except(response.body).to include(fredo.name)
      except(response.body).to include(jim.name)
      except(response.body).to_not include(kurty.name)
    end

    it "all valid characters appears in the game for game master view" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      fredo = Character.create(
          :name => "fredo",
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      kurt = User.new(
          :pseudo => 'kurt',
          :email => 'kurt.cobain@gmail.com',
          :encrypted_password => 'password')

      kurty = Character.create(
          :name => "kurty",
          :world_id => world.id,
          :character_type_id => 450,
          :user_id => kurt.id)

      jimi = User.new(
          :pseudo => 'jimi',
          :email => 'jimi.hendrix@gmail.com',
          :encrypted_password => 'password')

      jim = Character.create(
          :name => "jim",
          :world_id => world.id,
          :character_type_id => 450,
          :user_id => jimi.id)

      sign_in bob

      get :game, params: { id: world.id }
      except(response).to have_http_status(:success)

      except(response.body).to include(fredo.name)
      except(response.body).to include(jim.name)
      except(response.body).to_not include(kurty.name)
    end

  end


  describe "VIEW : appears in HOME" do

    it "Can view all characters" do
      bob = User.new(
          :pseudo => 'bob',
          :email => 'bob.marley@gmail.com',
          :encrypted_password => 'password')

      world = World.new(
          :name => 'jamminInaZionGarden',
          :public => 1,
          :user_id => bob.id)

      type = CharacterType.new

      freddy = User.new(
          :pseudo => 'freddy',
          :email => 'freddy.mercury@gmail.com',
          :encrypted_password => 'password')

      charac = Character.new(
          :name => 'fred',
          :world_id => world.id,
          :character_type_id => type.id,
          :user_id => freddy.id)

      sign_in freddy

      get :root
      expect(response).to have_http_status(:success)

      expect(response.body).to include(charac.name)
      expect(response.body).to_not include("You have not join a world yet!")
    end

  end


end
