require 'sinatra'
require 'sinatra/activerecord'

require './environments'

class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end


get '/' do
  @post = Post.order("created_at DESC")
  @title = "Welcome."
  erb :'posts/index'
end

post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    erb :"posts/create"
  end
end

get '/posts/create' do
  @title = "Create post"
  @post = Post.new
  erb :'posts/create'
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :'posts/view'
end



