require 'user_repository'

describe UserRepository do
  def reset_users_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_users_table
  end

  after(:all) do
    reset_users_table
  end

  it 'returns all users' do
    repo = UserRepository.new

    users = repo.all

    expect(users.length).to eq  7
    expect(users[0].id).to eq  1
    expect(users[0].name).to eq 'Pepito Callicott'
    expect(users[0].email).to eq 'pcallicott0@opensource.org'
    expect(users[0].username).to eq 'pcallicott0'
    expect(users[0].password).to eq '$2a$12$xvAuYORc90Q/B4FZ0eFWP.uWnlfJquXxAEaBjf32MaQKHf1i8I.sS'

    expect(users[1].id).to eq  2
    expect(users[1].name).to eq 'Drugi Leverson'
    expect(users[1].email).to eq 'dleverson1@cbsnews.com'
    expect(users[1].username).to eq 'dleverson1'
    expect(users[1].password).to eq  '$2a$12$WiEPw6ZTKxsDaGDwse1m1es8cCDPxe9lQuO5aRZeWCFl0ZXem0tp.'
  end

  it 'creates a new user' do
    repo = UserRepository.new
    user = User.new
    user.name = "Newlia Userson"
    user.email = "omgitsanewemail@hmail.com"
    user.username = "NewliaUsername"
    user.password = '$2a$12$jpoLZYPCL6tjCsIWGU3/8ePa3qz7nSMRvb8SnmtbhsOf'

    repo.create(user)
    users = repo.all

    expect(users.length).to eq 8
    expect(users.last.name).to eq "Newlia Userson"
    expect(users.last.email).to eq "omgitsanewemail@hmail.com"
    expect(users.last.username).to eq "NewliaUsername"
    expect(users.last.password).to include '$2a$12$' #this tests that the password is encypted
  end


  context '#find_by_email' do
    it 'finds user by email' do
      
      repo = UserRepository.new

      user = repo.find_by_email('bmckue3@hostgator.com')

      expect(user.id).to eq('4')    
    end
  end

  context '#sign in' do
    it 'returns ok if user supplies correct pass/email combo' do

      repo = UserRepository.new
      sign_in_result = repo.sign_in('bmckue3@hostgator.com', 'jamespates')
      expect(sign_in_result).to eq(true)
    end

    it 'returns false if user supplies correct pass/email combo' do

      repo = UserRepository.new
      sign_in_result = repo.sign_in('bmckue3@hostgator.com', 'patesjames')
      expect(sign_in_result).to eq(false)
    end
  end

end