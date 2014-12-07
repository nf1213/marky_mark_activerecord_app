#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"

require_relative 'models/actor'
require_relative 'models/movie'
require_relative 'models/cast_member'

## Copyright Nicole Felch Dec 6 2014
##
## This application finds a path from Mark Wahlberg to given actor via
## movies they have been in with other actors.
##
## COMMENTED CODE WAS USED TO POPULATE THE DATABASE WITH PATHS TO MARKY MARK
## AND SHOULD BE SAVED IN CASE DATABASE NEEDS TO BE RECREATED

class MarkyMarkApp
  attr_reader :result

  def initialize(target_actor_id)
    @result = []
    graph = Actor.all
    @target_actor_id = target_actor_id
    # Mark Wahlberg
    mrkymrk = graph.find(1841)

    #graph.update_all(distance: 1000)
    #graph.update_all(visited: false)
    #graph.update_all(previous: nil)

    #mrkymrk.update(distance: 0)
    begin
      target = graph.find(@target_actor_id)
      dijkstra(graph, mrkymrk, target)
    rescue
      @result << "Could not find actor with id ##{@target_actor_id}"
    end
  end

  # def closest_actor(g)
  #   g.min_by { |actor| actor.distance }
  # end

  def dijkstra(graph, start, target)
    t = target
    unvisited = graph
    first = "#{t.name}"
    unless t.previous.nil?
      until t.previous_actor.nil?
        arr = ["#{t.find_connection}", "#{t.previous_actor.name}"]
        @result << arr
        t = t.previous_actor
      end
      @result << first
      #exit(1)
    else
      @result << "#{t.name} has no relation to Mark Wahlberg."
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

end
