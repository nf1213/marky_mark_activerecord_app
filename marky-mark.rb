#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"

require 'colored'

require_relative 'models/actor'
require_relative 'models/movie'
require_relative 'models/cast_member'

# def closest_actor(g)
#   g.min_by { |actor| actor.distance }
# end

def dijkstra(graph, start, target)
  t = target
  unvisited = graph

  unless t.previous.nil?
    puts "\nHERE WE GO!\n\n".red
    puts "Actor: #{t.name}".cyan
    until t.previous_actor.nil?
      puts "Actor: #{t.previous_actor.name}".cyan
      t = t.previous_actor
    end
    exit(1)
  else
    puts "This actor has not relation to Mark Wahlberg.".red
  end

  # until unvisited.empty?
  #   unvisited = graph.where("visited = false")
  #   s = closest_actor(unvisited)
  #   s.neighbors.each do |id, n|
  #     puts "Looking at nodes, this could take a while...".cyan
  #     puts "Current: #{s.id}".yellow
  #     puts "Neighbor: #{n.id}".yellow
  #     dist = s.distance + 1
  #     if dist < n.distance
  #       n.update(distance: dist)
  #       n.update(previous: s.id)
  #     end
  #     # if n.id == t.id
  #     #   puts "\nHERE WE GO!\n\n".red
  #     #   puts "Actor: #{n.name}".cyan
  #     #   until n.previous_actor.nil?
  #     #     puts "Actor: #{n.previous_actor.name}".cyan
  #     #     n = n.previous_actor
  #     #   end
  #     #   exit(1)
  #     # else
  #       s.update(visited: true)
  #     # end
  #   end
  # end
end

if ARGV.length != 1
  puts "usage: #{__FILE__} \"<actor id>\""
  exit(1)
end

graph = Actor.all
#graph.update_all(distance: 1000)
#graph.update_all(visited: false)
#graph.update_all(previous: nil)

target_actor = ARGV[0].to_i
# Mark Wahlberg
mrkymrk = graph.find(1841)

#mrkymrk.update(distance: 0)
begin
  target = graph.find(target_actor)
  dijkstra(graph, mrkymrk, target)
rescue
  puts "Could not find actor with id ##{target_actor}".red
end
