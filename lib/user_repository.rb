require_relative './user'
require 'bcrypt'

class UserRepository

  def all
    sql = 'SELECT id, name, email, username, password FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |user|
      new_user = User.new

      new_user.id = user['id'].to_i
      new_user.name = user['name']
      new_user.email = user['email']
      new_user.username = user['username']
      new_user.password = user['password']

      users << new_user
    end

    return users
  end

  def create(user)
    encrypted_password = BCrypt::Password.create(user.password)

    sql = 'INSERT INTO users(email,password,name,username) VALUES ($1, $2, $3, $4);'
    params = [user.email, encrypted_password, user.name, user.username]
    
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def find_by_email(email)

    sql = 'SELECT id, email, username, password, name FROM users WHERE email = $1'
    params = [email]
    result_set = DatabaseConnection.exec_params(sql, params)

    user = User.new
    user.id = result_set[0]['id']
    user.email = result_set[0]['email']
    user.password = result_set[0]['password']

    return user

  end

  def sign_in(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?

    stored_password = BCrypt::Password.new(user.password)
    if stored_password == submitted_password
      return "hello"
    else
      return "bad"
    end
  end
end