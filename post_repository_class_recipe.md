# POSTS Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

## 3. Define the class names
``` ruby
class Post
end

class PostRepository
end
```

## 4. Implement the Model class

``` ruby
class Post
  attr_accessor :id, :title, :content, :views, :user_id
end
```

## 5. Define the Repository Class interface

```ruby
class PostRepository
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  def create(user)
  # INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);

  # Returns an array of Post objects which includes newly added Post object.
  end

  def delete(id)
  # DELETE FROM posts WHERE id = $1;

  # Returns an array of Post objects which excludes deleted Post object.
  end
  

  def update(user, id)
  # UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4  WHERE id = $5
  end
end
```

## 6. Write Test Examples

## 7. Reload the SQL seeds before each test run

## 8. Test-drive and implement the Repository class behaviour
