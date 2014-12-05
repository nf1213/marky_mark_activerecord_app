class Movie < ActiveRecord::Base
  has_many :cast_members
  has_many :actors, through: :cast_members
end
