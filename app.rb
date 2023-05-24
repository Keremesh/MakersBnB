require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/database_connection'
require_relative './lib/space_repository'
require_relative './lib/user_repository'
require 'Date'

DatabaseConnection.connect('makersbnb')

class Application < Sinatra::Base
  enable :sessions
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:index)
  end

  post '/login' do
    repo = UserRepository.new
    sign = User.new

    email = params[:email]
    password = params[:password]
  
    repo.sign_in(email, password)

    return nil
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    repo = UserRepository.new 
    new_user = User.new
    new_user.name = params[:name]
    new_user.username = params[:username] 
    new_user.email = params[:email] 
    new_user.password = params[:password] 

    repo.create(new_user)

    redirect to('/spaces/new')
  end

  get '/signednup' do
    return erb(:signedup)
  end

  post '/spaces/new' do
    repo = SpaceRepository.new
    new_space = Space.new
    new_space.title = params[:title]
    new_space.description = params[:description]
    new_space.price = params[:price].to_i
    new_space.address = params[:address]

    start_date = params[:start_date]
    end_date = params[:end_date]
    @available_dates = "[#{start_date}, #{end_date})"
    new_space.available_dates = @available_dates
    new_space.user_id = params[:user_id]

    repo.create(new_space)

    redirect('/')
  end

  get '/spaces/new' do
    return erb(:new_space)
  end



end
