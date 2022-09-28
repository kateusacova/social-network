# USERS Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

## 3. Define the class names

```ruby
class User
end

class UserRepository
end
```

## 4. Implement the Model class

```ruby
class User
  attr_accessor :id, :email, :username
end
```

## 5. Define the Repository Class interface

```ruby

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, username FROM users;

    # Returns an array of User objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, email, username FROM users WHERE id = $1;

    # Returns a single User object.
  end

  def create(user)
  # INSERT INTO users (email, username) VALUES ($1, $2);
  # Returns an array of User objects which includes newly added User object.
  end

  def delete(id)
  # DELETE FROM users WHERE id = $1;
  # Returns an array of User objects which excludes deleted User object.
  end
  

  def update(user, id)
  # UPDATE users SET email = $1 WHERE id = $2
  end
end
```

## 6. Write Test Examples

```ruby
# 1

# Get all users
repo = UserRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  "1"
users[0].username # =>  "kate"

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(2)

user.id # =>  "2"
user.username # => "john"

# 3

repo = UserRepository.new
user = User.new
user.email = "milana@gmail.com"
user.username = "milana"

repo.create(user)

all_users = repo.all # =>  should include new user

# 4 
repo = UserRepository.new
repo.delete(1)

all_users = repo.all # => should exclude user with id 1

# 5
repo = UserRepository.new
user = User.new
user.username = "kate_new"
repo.update(user, 1) 
repo.find(1) => # => should return user with updated username

```

## 7. Reload the SQL seeds before each test run


## 8. Test-drive and implement the Repository class behaviour

