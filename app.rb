require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './environments'

enable :sessions

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
    redirect "posts/#{@post.id}", :notice => 'Congrats! Love the new post.'
  else
    erb :"posts/create", :error => 'Something went wrong. Try again.'
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



