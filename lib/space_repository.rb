require_relative './space'

class SpaceRepository
  def all
    sql = 'SELECT id, title, description, price, address, available_dates, user_id FROM spaces;'

    result_set = DatabaseConnection.exec_params(sql, [])

    spaces = []
    p "user all working"
    result_set.each do |space|
      new_space = Space.new

      new_space.id = space["id"].to_i
      new_space.title = space["title"]
      new_space.description = space["description"]
      new_space.price = space["price"]
      new_space.address = space["address"]
      new_space.available_dates = space["available_dates"] #check return data type/presentation. (Josh, Kassandra, Kera)
      new_space.user_id = space["user_id"]

      spaces << new_space
    end

  return spaces
  end

  def create(space)
    sql = 'INSERT INTO spaces (title, description, price, address, available_dates, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    # sql_params = [space.title, space.description, space.price, space.address, space.available_dates, space.user_id]
    result_set = DatabaseConnection.exec_params(sql, [space.title, space.description, space.price, space.address, space.available_dates, space.user_id])

    return space

  end

end