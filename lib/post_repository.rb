require_relative "../lib/database_connection.rb"
require_relative "../lib/post.rb"

class PostRepository
  def all
    query = "SELECT id, title, content, views, user_id FROM posts;"
    params = []
    result = DatabaseConnection.exec_params(query, params)

    posts = []
    result.each { |record|
      posts << convert_to_object(record)
    }

    posts
  end

  def find(id)
    query = "SELECT id, title, content, views, user_id FROM posts WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)

    convert_to_object(result[0])
  end

  def create(post)
    query = "INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);"
    params = [post.title, post.content, post.views, post.user_id]
    result = DatabaseConnection.exec_params(query, params)
  end

  def delete(id)
    query = "DELETE FROM posts WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)
  end
  

  def update(post, id)
    query = "UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4  WHERE id = $5;"
    params = [post.title, post.content, post.views, post.user_id, post.id]
    result = DatabaseConnection.exec_params(query, params)
  end

  private

  def convert_to_object(record)
    post = Post.new
    post.id = record["id"]
    post.title = record["title"]
    post.content = record["content"]
    post.views = record["views"]
    post.user_id = record["user_id"]

    post
  end
end