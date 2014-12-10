#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"

require_relative 'marky_mark_app'
require_relative 'models/actor'

require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/movies')

get '/search' do
  input = params[:input]
  @result = Actor.where("name ILIKE ?", "%#{input}%").all
  erb :search
end

get '/:id' do
  id = params['id'].to_i
  @result = MarkyMarkApp.new(id).result
  erb :index
end

get '/' do
  @result = ["Search for an actor to find their 'Mark Wahlberg Number' (degrees of separation) and a path to Mark Wahlberg using movies."]
  erb :index
end
