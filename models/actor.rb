class Actor < ActiveRecord::Base
  has_many :cast_members
  has_many :movies, through: :cast_members

  def neighbors
    n = {}
    movies.each do |movie|
      movie.actors.each do |actor|
        n[actor.id] = actor
      end
    end
    n
  end

  def previous_actor
    prev = nil
    begin
      prev = self.class.find(self.previous)
    rescue
      prev = nil
    end
    prev
  end
end
