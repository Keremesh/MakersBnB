require 'space_repository'

def reset_spaces_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe SpaceRepository do
  before(:each) do 
    reset_spaces_table
  end

  after(:all) do
    reset_spaces_table
  end

  it 'return all spaces' do
    repo = SpaceRepository.new

    space = repo.all

    expect(space.length).to eq(4) 

    expect(space[0].id).to eq (1)
    expect(space[0].title).to eq ('Title1')
    expect(space[0].description).to eq('description1')
    expect(space[0].price).to eq('$12.00')
    expect(space[0].address).to eq('Address1')
    expect(space[0].available_dates).to eq("[\"2010-01-13 14:30:01\",\"2010-01-14 15:30:01\"]")
    expect(space[0].user_id).to eq('1')

    expect(space[1].id).to eq(2)
    expect(space[1].title).to eq('Title2')
    expect(space[1].description).to eq('description2')
    expect(space[1].price).to eq('$12.00')
    expect(space[1].address).to eq('Address2')
    expect(space[1].available_dates).to eq("[\"2010-01-14 14:30:01\",\"2010-01-15 15:30:01\"]")
    expect(space[1].user_id).to eq('2')
  end 

  it "creates a new space" do
    repo = SpaceRepository.new
    space = Space.new
    space.title = "Title5"
    space.description = "description5"
    space.price = "12.00"
    space.address = "Address5"
    space.available_dates = "[2010-01-18 14:30:01, 2010-01-19 15:30:01]"
    space.user_id = "3"

    repo.create(space)

    spaces = repo.all
    expect(spaces.length).to eq(5)
    expect(spaces.last.title).to eq "Title5"

  end
end