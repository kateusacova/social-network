require_relative "../lib/post_repository.rb"
require "dotenv/load"

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: "social_network_test", user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it "Returns an array of Post objects" do
    repo = PostRepository.new
    posts = repo.all
    expect(posts.length).to eq 2
    expect(posts[0].id).to eq "1"
    expect(posts[0].title).to eq "My Day"
  end

  it "Returns a single Post object" do
    repo = PostRepository.new
    post = repo.find(2)
    expect(post.id).to eq "2"
    expect(post.title).to eq "Another Day"
  end

  it "Returns an array of Post objects which includes newly added Post object" do
    repo = PostRepository.new
    post = Post.new
    post.title = "My Cat"
    post.content  = 'He is adorable!'
    post.views = 350
    post.user_id = 1
    repo.create(post)
    all_posts = repo.all
    expect(all_posts).to include(
      have_attributes(
        title: post.title,
        content: post.content,
        views: "350",
        user_id: "1"
      )
    )
  end

  it "Returns an array of Post objects which excludes deleted Post object" do
    repo = PostRepository.new
    repo.delete(1)
    expect(repo.all.length).to eq 1
  end

  it "Returns an updated Post object" do
    repo = PostRepository.new
    post = repo.find(1)
    post.title = "Best Day"
    
    repo.update(post, 1) 

    expect(repo.find(1).title).to eq post.title
    expect(repo.find(1).content).to eq "It was good!"
  end
end