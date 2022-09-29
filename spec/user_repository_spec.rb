require_relative "../lib/user_repository.rb"
require "dotenv/load"

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: "social_network_test", user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  it "Returns an array of User objects" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq 2
    expect(users[0].id).to eq "1"
    expect(users[0].username).to eq "kate"
  end

  it "Returns a single User object" do
    repo = UserRepository.new
    user = repo.find(2)
    expect(user.id).to eq "2"
    expect(user.username).to eq "john"
  end

  it "Returns an array of User objects which includes newly added User object" do
    repo = UserRepository.new
    user = User.new
    user.email = "milana@gmail.com"
    user.username = "milana"
    repo.create(user)
    all_users = repo.all
    expect(all_users).to include(
      have_attributes(
        email: user.email,
        username: user.username
      )
    )
  end

  it "Returns an array of User objects which excludes deleted User object" do
    repo = UserRepository.new
    repo.delete(1)
    users = repo.all
    expect(users.length).to eq 1
  end

  it "Returns an updated User object" do
    repo = UserRepository.new
    user = repo.find(1)
    user.username = "Something else"
    user.email = "Something else email"
    
    repo.update(user) 

    expect(repo.find(1).username).to eq user.username
    expect(repo.find(1).email).to eq user.email
  end

  it "Returns an updated User object" do
    repo = UserRepository.new
    user = repo.find(1)
    user.username = "Test"
    
    repo.update(user) 

    expect(repo.find(1).username).to eq user.username
    expect(repo.find(1).email).to eq "kate@gmail.com"
  end
end