require_relative "../lib/database_connection.rb"
require_relative "../lib/user.rb"

class UserRepository
  def all
    query = "SELECT id, email, username FROM users;"
    params = []
    result = DatabaseConnection.exec_params(query, params)

    users = []

    result.each { |record|
      users << convert_to_object(record)
    }
    
    users
  end

  def find(id)
    query = "SELECT id, email, username FROM users WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)

    convert_to_object(result[0])
  end

  def create(user)
    query = "INSERT INTO users (email, username) VALUES ($1, $2);"
    params = [user.email, user.username]
    result = DatabaseConnection.exec_params(query, params)
  end

  def delete(id)
    query = "DELETE FROM users WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)
  end
  

  def update(user, id)
    query = "UPDATE users SET email = $1, username = $2  WHERE id = $3;"
    params = [user.email, user.username, id]
    result = DatabaseConnection.exec_params(query, params)
  end

  private

  def convert_to_object(record)
    user = User.new
    user.id = record["id"]
    user.email = record["email"]
    user.username = record["username"]

    user
  end

end