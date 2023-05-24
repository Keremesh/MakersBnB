require "spec_helper"
require "rack/test"
require_relative '../../app.rb'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.
  #repo = UserRepository.new
  

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>ebnb</h1>')
      
    end
  end

  context 'GET /spaces/new' do
    it 'posts data to a form' do
      response = get('/spaces/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('form action="/spaces/new" method="POST"')
      expect(response.body).to include('input type="text" name="title"')
      
    end
  end

  context 'GET /' do
    it 'prints all spaces to the homepage' do
      response = get('/')

      expect(response.body).to include '<p class=description>Title4</p>'
      expect(response.body).to include '<p class=price>$12.00</p>'
      expect(response.body).to include '<p class=address>Address2</p>'
      expect(response.body).to include '<p class=available_dates>Available from: 2010-01-13  to: 2010-01-14</p>'
    end
  end


  context 'POST /spaces/new' do
    it 'submittes the form and redirect to homepage' do
      response = post('/spaces/new',
      title: 'outside',
      description: 'a very large open space',
      price: '0',
      address: 'anywhare you like',
      start_date: '2023-03-16 00:00:00',
      end_date: "2023-03-18 00:00:00",
      user_id: 3)

      expect(response.status).to eq(302)
      expect(response).to be_redirect
      
    end

    

  end
end
